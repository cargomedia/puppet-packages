class build::automake {

  require 'apt'

  package { 'automake':
    provider => 'apt',
  }
}
