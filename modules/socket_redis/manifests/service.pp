class socket_redis::service {

  service {'socket-redis':
    require => Package['socket-redis'],
  }
}
