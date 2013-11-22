class mysql::service {

  include 'mysql::server'

  service {'mysql':
    require => Package['mysql-server'],
  }
}
