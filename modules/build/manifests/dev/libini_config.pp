class build::dev::libini_config {

  require 'apt'

  package { 'libini-config-dev':
    provider => 'apt',
  }
}
