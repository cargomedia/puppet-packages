class sudo {

  require 'apt'

  package { 'sudo':
    provider => 'apt',
    ensure => present,
  }
}
