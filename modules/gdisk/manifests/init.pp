class gdisk {

  require 'apt'

  package { 'gdisk':
    ensure => present,
    provider => 'apt',
  }
}
