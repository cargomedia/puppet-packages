class cron {

  require 'apt'

  package { 'cron':
    ensure   => present,
    provider => 'apt',
  }
  ~>

  exec { '/etc/init.d/cron stop':
    command     => '/etc/init.d/cron stop',
    path        => ['/bin','/usr/bin'],
    refreshonly => true,
  }

  daemon { 'cron':
    binary       => '/usr/sbin/cron',
    args         => '-f',
    post_command => 'rm -f /var/run/crond.pid',
  }
}
