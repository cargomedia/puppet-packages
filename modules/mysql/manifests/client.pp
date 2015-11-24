class mysql::client {

  require 'apt'

  package { 'mysql-client':
    provider => 'apt',
    ensure => present,
  }
}
