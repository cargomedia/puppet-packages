class rdiff_backup {

  require 'apt'

  package { 'rdiff-backup':
    ensure   => installed,
    provider => 'apt',
  }
}
