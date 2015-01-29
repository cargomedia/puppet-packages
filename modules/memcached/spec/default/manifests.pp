node default {

  require 'monit'

  class { 'memcached':
    max_connections => 99
  }
}
