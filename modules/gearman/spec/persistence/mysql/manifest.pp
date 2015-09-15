node default {

  require 'mysql::server'

  mysql::user { 'gearman@127.0.0.1':
    password => 'gearman'
  }
  ->

  mysql::database { 'gearman':
    user => 'gearman@127.0.0.1'
  }
  ->

  class { 'gearman::server':
    persistence    => 'mysql',
    mysql_user     => 'gearman',
    mysql_password => 'gearman'
  }
}
