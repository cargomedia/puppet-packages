node default {

  class { 'memcached':
    max_connections => 99
  }
}
