class mysqltuner {

  require 'apt'

  package { 'mysqltuner':
    ensure   => present,
    provider => 'apt',
  }
}
