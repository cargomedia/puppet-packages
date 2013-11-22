class mysql::proxy ($host = 'localhost', $port = 4040, $backend_addresses) {

  package {'mysql-proxy':
    ensure => present,
  }

  @monit::entry {'mysql-proxy':
    content => template('mysql/proxy/monit'),
  }
}
