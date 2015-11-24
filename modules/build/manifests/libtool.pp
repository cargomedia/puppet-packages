class build::libtool {

  require 'apt'

  package { 'libtool':
    ensure   => present,
    provider => 'apt',
  }
}
