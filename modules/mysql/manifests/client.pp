class mysql::client {

  require 'apt'

  package { 'mysql-client':
    ensure   => present,
    provider => 'apt',
  }
}
