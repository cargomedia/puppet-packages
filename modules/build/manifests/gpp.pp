class build::gpp {

  require 'apt'

  package { 'g++':
    provider => 'apt',
  }
}
