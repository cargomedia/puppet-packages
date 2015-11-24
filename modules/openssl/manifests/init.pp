class openssl {

  require 'apt'

  package { 'openssl':
    ensure => present,
    provider => 'apt',
  }
}
