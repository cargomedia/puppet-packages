class cron {

  require 'apt'

  package { 'cron':
    ensure   => present,
    provider => 'apt',
  }
  ->

  exec { 'stop package-provided cron':
    command => '/etc/init.d/cron stop',
    path    => ['/bin','/usr/bin'],
    unless  => 'ps ax | grep -q \'cron -f\''
  }

  daemon { 'cron':
    binary       => '/usr/sbin/cron',
    args         => '-f',
    post_command => '/bin/rm -f /var/run/crond.pid',
  }
}
