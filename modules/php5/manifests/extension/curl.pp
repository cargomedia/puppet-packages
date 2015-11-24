class php5::extension::curl {

  require 'apt'
  require 'php5'

  package { 'php5-curl':
    ensure   => present,
    provider => 'apt',
  }
}
