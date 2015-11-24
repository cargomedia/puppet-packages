class build::cmake {

  require 'apt'

  package { 'cmake':
    ensure   => present,
    provider => 'apt',
  }
}
