class build::autoconf {

  require 'apt'

  package { 'autoconf':
    ensure => present,
    provider => 'apt',
  }
}
