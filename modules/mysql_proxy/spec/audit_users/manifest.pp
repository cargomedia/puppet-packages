node default {

  require 'mysql::server'
  require 'mysql::client'

  mysql::user { 'foo@%':
    password => 'pass'
  }
  mysql::user { 'bar@%':
    password => 'pass'
  }

  class { 'mysql_proxy':
    backend_addresses => ['127.0.0.1:3306'],
    audit_users       => ['foo']
  }
}
