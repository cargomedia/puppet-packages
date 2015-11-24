class openssl {

  require 'apt'

  package { 'openssl':
    provider => 'apt',
    ensure => present,
  }
}
