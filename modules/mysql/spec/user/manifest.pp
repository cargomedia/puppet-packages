node default {

  class {'apt::update':
    before => Class['mysql::server'],
  }

  class {'mysql::server':}

  mysql::user {'foo@localhost':
    password => 'bar',
  }
}
