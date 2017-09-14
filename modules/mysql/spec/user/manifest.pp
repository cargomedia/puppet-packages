node default {

  require 'mysql::server'

  mysql::user { 'foo@localhost':
    password => 'mypass',
  }

  mysql::user { 'bar@localhost':
  }
}
