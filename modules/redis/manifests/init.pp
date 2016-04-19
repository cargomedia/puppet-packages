class redis {

  require 'apt'

  $config_file = $::lsbdistcodename ? {
    'wheezy' => 'redis-2.4.conf',
    default => 'redis-2.6.conf',
  }

  if $::lsbdistcodename == 'wheezy' {
    $sysctl_entries = {
      'vm.overcommit_memory' => '1',
    }
  } else {
    $sysctl_entries = {
      'vm.overcommit_memory'         => '1',
      'net.core.somaxconn'           => 512,
      'net.ipv4.tcp_max_syn_backlog' => 512,
    }
  }

  file { '/etc/redis':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { '/etc/redis/redis.conf':
    ensure  => file,
    content => template("${module_name}/${config_file}"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

  sysctl::entry { 'redis':
    entries => $sysctl_entries,
  }
  ->
  # Ugly hack to prevent postinstall trying to start redis-server
  exec { 'truncate /etc/init.d/redis-server':
    command     => "echo -e '#!/bin/sh\n\nexit 0' > /etc/init.d/redis-server",
    unless      => 'dpkg-query -W redis-server',
    provider    => shell,
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  package { 'redis-server':
    provider => 'apt',
    require  => File['/etc/redis/redis.conf'],
  }

  daemon { 'redis-server':
    binary  => '/usr/bin/redis-server',
    args    => '/etc/redis/redis.conf',
    user    => 'redis',
    require => Package['redis-server'],
  }

  @bipbip::entry { 'redis':
    plugin  => 'redis',
    options => {
      'hostname' => 'localhost',
      'port'     => '6379',
    },
    require => Daemon['redis-server'],
  }
}
