class lvm::base::xfs {

  require 'apt'

  package { 'xfsprogs':
    provider => 'apt',
    ensure => installed,
  }
}
