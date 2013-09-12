class apt::cron-apt {

  require 'apt'

  package {'cron-apt':
    ensure => present,
    require => File['/etc/cron-apt/config'],
  }

  file {'/etc/cron-apt':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {'/etc/cron-apt/config':
    ensure => file,
    content => template("${module_name}/cron-apt-config"),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
