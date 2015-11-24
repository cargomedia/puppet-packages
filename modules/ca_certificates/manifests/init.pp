class ca_certificates {

  require 'apt'

  package { 'ca-certificates':
    ensure   => present,
    provider => 'apt',
  }
}
