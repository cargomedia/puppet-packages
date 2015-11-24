class rdiff_backup {

  require 'apt'

  package { 'rdiff-backup':
    provider => 'apt',
    ensure => installed,
  }
}
