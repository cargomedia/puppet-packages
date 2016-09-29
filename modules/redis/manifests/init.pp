class redis {

  require 'apt'
  include 'redis::service'

  sysctl::entry { 'redis':
    entries => {
      'vm.overcommit_memory'         => '1',
      'net.core.somaxconn'           => 512,
      'net.ipv4.tcp_max_syn_backlog' => 512,
    },
  }

  file { '/etc/redis':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { '/etc/redis/redis.conf':
    ensure  => file,
    content => template("${module_name}/redis.conf"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['redis-server'],
  }

  package { 'redis-server':
    provider => 'apt',
  }

  @monit::entry { 'redis':
    content => template("${module_name}/monit.erb"),
    require => Package['redis-server'],
  }

  @bipbip::entry { 'redis':
    plugin  => 'redis',
    options => {
      'hostname' => 'localhost',
      'port'     => '6379',
    },
    require => Service['redis-server'],
  }
}
