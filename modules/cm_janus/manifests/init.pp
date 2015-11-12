class cm_janus (
  $version = '0.0.1',
  $http_port = 8888,
  $api_key = 'unknown',
  $proxy_port = 8188,
  $proxy_upstream = 'ws://198.23.87.26:8188/janus',
  $cm_api_base_url = 'http://www.cm.dev',
  $cm_api_key = 'anotherunknown',
  $log_file_path = '/var/log/cm-janus/cm-janus.log',
) {

  require 'nodejs'
  include 'cm_janus::service'

  file { '/etc/cm-janus':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/cm-janus/config.yaml':
    ensure => file,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  user { 'cm-janus':
    ensure => present,
    system => true,
  }

  file { $logDir:
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => User['cm-janus']
  }

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate")
  }

  sysvinit::script { 'cm-janus':
    content           => template("${module_name}/init.sh"),
    require           => [Package['cm-janus'], User['cm-janus']],
  }

  package { 'cm-janus':
    ensure   => $version,
    provider => 'npm',
  }

  @monit::entry { 'cm-janus':
    content => template("${module_name}/monit"),
    require => Service['cm-janus'],
  }
#TODO: add bipbip

}
