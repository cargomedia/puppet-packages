class build::make {

  require 'apt'

  package { 'make':
    provider => 'apt',
  }
}
