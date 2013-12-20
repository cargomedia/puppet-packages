class memcached ($port = 11211, $memory = 2048, $user = 'nobody') {

  include 'memcached::service'

  file {'/etc/memcached.conf':
    ensure => file,
    content => template('memcached/memcached.conf'),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service['memcached'],
  }
  ->

  package {'memcached':
    ensure => present,
  }

  @monit::entry {'memcached':
    content => template('memcached/monit'),
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
