node default {

  require 'mysql::server'
  require 'mysql::client'

  class { 'mysql_proxy':
    backend_addresses => ['127.0.0.1:3306', '127.0.0.2:3306'],
    failover => false,
  }
}
