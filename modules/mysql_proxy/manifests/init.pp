class mysql_proxy ($host = '127.0.0.1', $port = 4040, $backend_addresses) {

  require 'apt::source::cargomedia'

  file {'/etc/mysql-proxy':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }

  file {'/etc/mysql-proxy/config':
    ensure => file,
    content => template('mysql_proxy/config'),
    owner => '0',
    group => '0',
    mode => '0640',
    before => Package['mysql-proxy'],
    notify => Service['mysql-proxy'],
  }

  file {'/etc/mysql-proxy/failover.lua':
    ensure => file,
    content => template('mysql_proxy/failover.lua'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['mysql-proxy'],
    notify => Service['mysql-proxy'],
  }

  file {'/etc/default/mysql-proxy':
    ensure => file,
    content => template('mysql_proxy/default'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['mysql-proxy'],
    notify => Service['mysql-proxy'],
  }

  package {'mysql-proxy':
    ensure => present,
    notify => Service['mysql-proxy'],
    require => Class['apt::source::cargomedia'],
  }

  service {'mysql-proxy':}

  @monit::entry {'mysql-proxy':
    content => template('mysql_proxy/monit'),
    require => Package['mysql-proxy'],
  }
}
