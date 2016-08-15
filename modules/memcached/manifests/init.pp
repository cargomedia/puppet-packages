class memcached (
  $port = 11211,
  $memory = 2048,
  $user = 'nobody',
  $max_connections = 10000
) {

  require 'apt'

  package { 'memcached':
    ensure   => present,
    provider => 'apt',
  }

  exec { 'true && /etc/init.d/memcached stop':
    path         => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider     => shell,
    subscribe    => Package['memcached'],
    refreshonly  => true,
  }

  daemon { 'memcached':
    binary  => '/usr/bin/memcached',
    args    => "-p ${port} -m ${memory} -u ${user} -c ${max_connections} -v",
    require => Package['memcached'],
  }

  @bipbip::entry { 'memcached':
    plugin  => 'memcached',
    options => {
      'hostname' => 'localhost',
      'port' => $port,
    }
  }
}
