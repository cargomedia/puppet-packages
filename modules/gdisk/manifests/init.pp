class gdisk {

  require 'apt'

  package { 'gdisk':
    provider => 'apt',
    ensure => present,
  }
}
