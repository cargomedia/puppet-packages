class lvm::base::xfs {

  require 'apt'

  package { 'xfsprogs':
    ensure => installed,
    provider => 'apt',
  }
}
