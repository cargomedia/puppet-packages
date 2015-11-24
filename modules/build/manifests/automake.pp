class build::automake {

  require 'apt'

  package { 'automake':
    ensure   => present,
    provider => 'apt',
  }
}
