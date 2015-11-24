class mysqltuner {

  require 'apt'

  package { 'mysqltuner':
    provider => 'apt',
    ensure => present,
  }
}
