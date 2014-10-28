node default {

  require 'monit'

  class {'memcached':
    max_connections => 99,
    log_verbosity => 1024
  }
}
