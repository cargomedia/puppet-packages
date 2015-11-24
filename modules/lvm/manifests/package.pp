class lvm::package {

  require 'apt'

  package { 'lvm2':
    ensure   => installed,
    provider => 'apt',
  }
}
