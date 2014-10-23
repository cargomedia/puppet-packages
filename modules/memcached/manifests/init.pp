class memcached (
  $port = 11211,
  $memory = 2048,
  $user = 'nobody',
  $max_connections = 10000
) {

  include 'memcached::service'

  file {'/etc/memcached.conf':
    ensure => file,
    content => template("${module_name}/memcached.conf"),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service['memcached'],
    before => Package['memcached'],
  }

  file {['/usr/share/memcached/','/usr/share/memcached/scripts/']:
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }

  file {'/usr/share/memcached/scripts/start-memcached':
    ensure => file,
    content => template("${module_name}/start-memcached.pl"),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['memcached'],
  }

  package {['memcached','moreutils']:
    ensure => present,
  }

  @monit::entry {'memcached':
    content => template("${module_name}/monit"),
    require => Service['memcached'],
  }

  @bipbip::entry {'memcached':
    plugin => 'memcached',
    options => {
      'hostname' => 'localhost',
      'port' => $port,
    }
  }
}
