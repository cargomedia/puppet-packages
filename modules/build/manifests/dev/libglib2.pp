class build::dev::libglib2 {

  require 'apt'

  package { 'libglib2.0-dev':
    provider => 'apt',
  }
}
