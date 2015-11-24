class build::dev::zlib1g {

  require 'apt'

  package { 'zlib1g-dev':
    ensure   => installed,
    provider => 'apt',
  }

}
