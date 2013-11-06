class memcached::service {

  service {'memcached':
    require => Package['memcached'],
  }
}
