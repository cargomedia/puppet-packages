class lvm::base::xfs {

  package {'xfsprogs':
    ensure => installed,
  }
}