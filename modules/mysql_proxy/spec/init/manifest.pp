node default {

  require 'mysql::server'
  require 'mysql::client'

  mysql::database { 'example_db':
  }

  class { 'mysql_proxy':
    backend_addresses => ['127.0.0.1:3306', '127.0.0.2:3306'],
  }
}
