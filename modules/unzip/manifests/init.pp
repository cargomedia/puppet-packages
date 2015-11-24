class unzip {

  require 'apt'

  package { 'unzip':
    provider => 'apt',
    ensure => present,
  }
}
