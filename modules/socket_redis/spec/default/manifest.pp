node default {

  require 'monit'

  class { 'socket_redis':
    socketPorts => [8090,8091],
  }
}
