class cron {

  require 'apt'

  package { 'cron':
    ensure   => present,
    provider => 'apt',
  }

  daemon { 'cron':
    binary       => '/usr/sbin/cron',
    args         => '-f',
    post_command => '/bin/rm -f /var/run/crond.pid',
    require      => Package['cron'],
  }

  exec { 'kill running cron when service created':
    command     => 'pkill cron',
    path        => ['/bin','/usr/bin'],
    subscribe   => Service['cron'],
    refreshonly => true,
  }
}
