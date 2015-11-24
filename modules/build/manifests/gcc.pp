class build::gcc {

  require 'apt'

  package { 'gcc':
    ensure => present,
    provider => 'apt',
  }
}
