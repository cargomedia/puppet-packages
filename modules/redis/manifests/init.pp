class redis {

  $version = '2.4.17'
  require 'build'

  helper::script {'install redis-server':
    content => template('redis/install.sh'),
    unless => "test -x /usr/local/bin/redis-server && /usr/local/bin/redis-server --version | grep '${version}'",
  }
  ->

  file {'/etc/redis.conf':
    ensure => file,
    content => template('redis/redis.conf'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ->

  file {'/etc/sysctl.d/redis.conf':
    ensure => file,
    content => template('redis/sysctl.d/redis.conf'),
    owner => '0',
    group => '0',
    mode => '0644',
  }

  ->
  user {'redis':
    ensure => present,
    system => true,
  }
  ->

  file {'/etc/init.d/redis':
    ensure => file,
    content => template('redis/init.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
  }
  ~>

  exec {'update-rc.d redis defaults  && /etc/init.d/redis start':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  @monit::entry {'redis':
    content => template('redis/monit'),
    require => File['/etc/init.d/redis'],
  }

  @bipbip::entry {'redis':
    plugin => 'redis',
    options => {
      'hostname' => 'localhost',
      'port' => '6379',
    }
  }
}
