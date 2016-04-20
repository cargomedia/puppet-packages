class redis {

  require 'apt'

  $config_file = $::lsbdistcodename ? {
    'wheezy' => 'redis-2.4.conf',
    default  => 'redis-2.6.conf',
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

  sysctl::entry { 'redis':
    entries => $sysctl_entries,
  }

  file { '/etc/redis':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  # Changing the config after package install (no daemonizing, listen to network)
  file { '/etc/redis/redis.conf':
    ensure    => file,
    content   => template("${module_name}/${config_file}"),
    owner     => '0',
    group     => '0',
    mode      => '0644',
    require   => Package['redis-server'],
  }

  package { 'redis-server':
    provider => 'apt',
  }

  # Ugly hack to cleanly adapt redis-server
  exec { 'stop redis-server':
    command  => '/etc/init.d/redis-server stop',
    unless   => '/etc/init.d/redis-server status',
    provider => shell,
    path     => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    before   => Service['redis-server'],
    require => Package['redis-server'],
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
