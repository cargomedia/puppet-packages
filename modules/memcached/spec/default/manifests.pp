node default {

  require 'monit'

  class {'bipbip':
    api_key => 'foo'
  }

  class {'memcached':
    max_connections => 99,
    log_verbosity => 3
  }
}
