class memcached ($port = 11211, $memory = 2048, $user = 'nobody') {

  file {'/etc/memcached.conf':
    ensure => file,
    content => template('memcached/memcached.conf'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ->

  package {'memcached':
    ensure => present,
  }
}
