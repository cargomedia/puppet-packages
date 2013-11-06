class socket-redis::service {

  service {'socket-redis':
    require => Package['socket-redis'],
  }
}
