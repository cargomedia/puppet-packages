class build::make {

  require 'apt'

  package { 'make':
    ensure => present,
    provider => 'apt',
  }
}
