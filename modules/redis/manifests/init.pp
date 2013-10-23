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
  ->

  monit::entry {'redis':
    content => template('redis/monit'),
  }
}
