class build::gpp {

  require 'apt'

  package { 'g++':
    ensure   => present,
    provider => 'apt',
  }
}
