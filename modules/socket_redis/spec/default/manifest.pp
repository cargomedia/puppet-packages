node default {

  require 'monit'

  class { 'socket_redis': }
}
