class mysql::client {

  require 'apt'
  require 'apt::source::mysql'

  package { 'mysql-client':
    ensure   => present,
    provider => 'apt',
    require  => Class['apt::source::mysql'],
  }
}
