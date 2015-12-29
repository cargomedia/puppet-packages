class build::libtool {

  require 'apt'

  package { 'libtool':
    provider => 'apt',
  }
}
