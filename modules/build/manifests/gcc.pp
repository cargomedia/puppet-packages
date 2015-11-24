class build::gcc {

  require 'apt'

  package { 'gcc':
    provider => 'apt',
    ensure => present,
  }
}
