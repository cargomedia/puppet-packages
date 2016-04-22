class redis {

  require 'apt'
  include 'redis::service'

  $config_file = $::lsbdistcodename ? {
    'wheezy' => 'redis-2.4.conf',
    default  => 'redis-2.6.conf',
  }

  if $::lsbdistcodename == 'wheezy' {
    $sysctl_entries = {
      'vm.overcommit_memory' => '1',
    }
    $init_system = 'sysvinit'
  } else {
    $sysctl_entries = {
      'vm.overcommit_memory'         => '1',
      'net.core.somaxconn'           => 512,
      'net.ipv4.tcp_max_syn_backlog' => 512,
    }
    $init_system = 'systemd'
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

  file { '/etc/redis/redis.conf':
    ensure  => file,
    content => template("${module_name}/${config_file}"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['redis-server'],
  }

  package { 'redis-server':
    provider => 'apt',
  }

  @monit::entry { 'redis':
    content => template("${module_name}/monit.${init_system}.erb"),
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
