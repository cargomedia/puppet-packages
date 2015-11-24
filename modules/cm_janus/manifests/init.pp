class cm_janus (
  $http_server_port = 8200,
  $http_server_api_key,
  $websockets_listen_port = 8210,
  $websockets_janus_address = 'ws://127.0.0.1:8300/janus',
  $cm_api_base_url,
  $cm_api_key,
  $cm_application_path,
  $jobs_path = '/var/lib/janus/jobs',
) {

  require 'nodejs'
  require 'build::gpp'
  include 'cm_janus::service'

  file { '/etc/cm-janus':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/cm-janus/config.yaml':
    ensure  => file,
    content => template("${module_name}/config.yaml"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    notify  => Service['cm-janus'],
  }

  user { 'cm-janus':
    ensure => present,
    system => true,
  }

  file { '/var/log/cm-janus':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => User['cm-janus'],
  }

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate")
  }

  sysvinit::script { 'cm-janus':
    content           => template("${module_name}/init.sh"),
    require           => [Package['cm-janus'], User['cm-janus']],
  }

  package { 'cm-janus':
    ensure   => latest,
    provider => 'npm',
    notify  => Service['cm-janus'],
  }

  @monit::entry { 'cm-janus':
    content => template("${module_name}/monit"),
    require => Service['cm-janus'],
  }

  #TODO: add bipbip

}
