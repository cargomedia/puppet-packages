class ca_certificates {

  require 'apt'

  package { 'ca-certificates':
    provider => 'apt',
    ensure => present,
  }
}
