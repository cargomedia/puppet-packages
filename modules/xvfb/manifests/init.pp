class xvfb {

  require 'apt'

  package { 'xvfb':
    ensure   => present,
    provider => 'apt',
  }
}
