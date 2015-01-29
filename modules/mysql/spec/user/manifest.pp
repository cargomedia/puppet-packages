node default {

  class { 'mysql::server': }

  mysql::user { 'foo@localhost':
    password => 'bar',
  }
}
