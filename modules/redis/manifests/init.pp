class redis {

  file {'/etc/redis':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ->

  file {'/etc/redis/redis.conf':
    ensure => file,
    content => template('redis/redis.conf'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ->

  sysctl::entry {'redis':
    entries => {
      'vm.overcommit_memory' => '1',
    },
  }
  ->

  package {'redis-server':
    ensure => present,
  }

  @monit::entry {'redis':
    content => template('redis/monit'),
    require => Package['redis-server'],
  }

  @bipbip::entry {'redis':
    plugin => 'redis',
    options => {
      'hostname' => 'localhost',
      'port' => '6379',
    },
    require => Package['redis-server'],
  }
}
