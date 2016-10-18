node default {

  class { 'socket_redis':
    statusPort  => '7085',
    socketPorts => [7090,7091],
  }
}
