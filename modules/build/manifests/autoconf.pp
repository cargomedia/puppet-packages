class build::autoconf {

  require 'apt'

  package { 'autoconf':
    provider => 'apt',
  }
}
