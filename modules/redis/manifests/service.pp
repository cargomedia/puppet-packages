class redis::service {

  service { 'redis-server':
    enable  => true,
    require => Package['redis-server'],
  }
}
