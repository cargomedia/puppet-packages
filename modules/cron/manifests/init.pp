class cron {

  require 'apt'

  package { 'cron':
    ensure   => present,
    provider => 'apt',
  }
  ->

  daemon { 'cron':
    binary => '/usr/sbin/cron',
    args   => '-f',
  }
}
