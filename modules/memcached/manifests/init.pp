class memcached (
  $bind_ip = '0.0.0.0',
  $port = 11211,
  $memory = 2048,
  $max_connections = 10000
) {

  require 'apt'

  package { 'memcached':
    ensure   => present,
    provider => 'apt',
  }
  ~>

  exec { 'systemctl stop memcached;systemctl disable memcached':
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
    before      => [File['/etc/init.d/memcached'], Daemon['memcached']],
    refreshonly => true,
  }

  file { '/etc/init.d/memcached':
    ensure  => file,
    content => template("${module_name}/init-replacement"),
    mode    => '0755',
    owner   => 0,
    group   => 0;
  }

  daemon { 'memcached':
    binary  => '/usr/bin/memcached',
    args    => "-p ${port} -m ${memory} -u memcache -l ${bind_ip} -c ${max_connections} -v",
    require => Package['memcached'],
  }

  @bipbip::entry { 'memcached':
    plugin  => 'memcached',
    options => {
      'hostname' => 'localhost',
      'port'     => $port,
    }
  }
}
