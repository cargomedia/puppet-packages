class backup::base::rdiff {

  package {'rdiff-backup':
    ensure => installed,
  }
}