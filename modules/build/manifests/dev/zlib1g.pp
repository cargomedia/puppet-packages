class build::dev::zlib1g {

  require 'apt'

  package { 'zlib1g-dev':
    provider => 'apt',
  }

}
