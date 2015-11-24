class sudo {

  require 'apt'

  package { 'sudo':
    ensure   => present,
    provider => 'apt',
  }
}
