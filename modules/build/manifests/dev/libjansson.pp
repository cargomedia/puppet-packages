class build::dev::libjansson {

  require 'apt'

  package { 'libjansson-dev':
    provider => 'apt',
  }
}
