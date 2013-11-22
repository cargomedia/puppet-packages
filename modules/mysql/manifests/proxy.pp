class mysql::proxy {

  package {'mysql-proxy':
    ensure => present,
  }

  @monit::entry {'mysql-proxy':
    content => template('mysql/proxy/monit'),
  }
}
