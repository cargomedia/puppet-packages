class lvm::package {

  require 'apt'

  package { 'lvm2':
    provider => 'apt',
    ensure => installed,
  }
}
