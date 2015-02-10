class socket_redis::service {

  service { 'socket-redis':
    enable  => true,
    require => Package['socket-redis'],
  }
}
