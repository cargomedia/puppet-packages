class build::dev::libopus {

  require 'apt'

  package { 'libopus-dev':
    provider => 'apt',
  }
}
