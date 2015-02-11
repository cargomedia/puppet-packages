class memcached::service {

  service { 'memcached':
    enable  => true,
    require => Package['memcached'],
  }
}
