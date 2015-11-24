class php5::extension::gd {

  require 'apt'
  require 'php5'

  package { 'php5-gd':
    provider => 'apt',
    ensure => present,
  }
}
