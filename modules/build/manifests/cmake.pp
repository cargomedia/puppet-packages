class build::cmake {

  require 'apt'

  package { 'cmake':
    provider => 'apt',
    ensure => present,
  }
}
