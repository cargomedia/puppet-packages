class apt::cron-apt {

  require 'apt'

  package {'cron-apt':
    ensure => present,
  }

  file {'/etc/cron-apt':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {'/etc/cron-apt/config':
    ensure => file,
    content => template('apt/cron-apt-config'),
    owner => '0',
    group => '0',
    mode => '0644',
    require => File['/etc/cron-apt'],
  }
}
