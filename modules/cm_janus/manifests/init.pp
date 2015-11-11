class cm_janus (
  $version = '0.0.1',
  $logDir = '/var/log/cm-janus',
) {

  require 'nodejs'
  include 'cm_janus::service'

  file { '/etc/cm-janus':
    ensure => directory,
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
    owner   => 'cm-janus',
    group   => 'cm-janus',
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
