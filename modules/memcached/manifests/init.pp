class memcached (
  $port = 11211,
  $memory = 2048,
  $user = 'nobody',
  $max_connections = 10000
) {

  require 'apt'
  include 'memcached::service'

  file { '/etc/memcached.conf':
    ensure  => file,
    content => template("${module_name}/memcached.conf"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['memcached'],
  }

  package { 'memcached':
    ensure   => present,
    provider => 'apt',
    require  => File['/etc/memcached.conf'],
  }

  @monit::entry { 'memcached':
    content => template("${module_name}/monit"),
    require => Service['memcached'],
  }

  @bipbip::entry { 'memcached':
    plugin  => 'memcached',
    options => {
      'hostname' => 'localhost',
      'port' => $port,
    }
  }
}
