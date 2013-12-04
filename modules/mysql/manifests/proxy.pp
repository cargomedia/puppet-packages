class mysql::proxy ($host = 'localhost', $port = 4040, $backend_addresses) {

  file {'/etc/mysql-proxy':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }

  file {'/etc/mysql-proxy/failover.lua':
    ensure => file,
    content => template('mysql/proxy/failover.lua'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['mysql-proxy'],
  }

  file {'/etc/default/mysql-proxy':
    ensure => file,
    content => template('mysql/proxy/default'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['mysql-proxy'],
    notify => Service['mysql-proxy'],
  }

  package {'mysql-proxy':
    ensure => present,
    notify => Service['mysql-proxy'],
  }

  service {'mysql-proxy':}

  @monit::entry {'mysql-proxy':
    content => template('mysql/proxy/monit'),
    require => Package['mysql-proxy'],
  }
}
