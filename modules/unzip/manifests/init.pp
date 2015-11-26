class unzip {

  require 'apt'

  package { 'unzip':
    ensure   => present,
    provider => 'apt',
  }
}
