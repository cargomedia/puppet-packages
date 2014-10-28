node default {

  require 'monit'

  class {'bipbip':
    api_key => 'foo'
  }

  class {'memcached':
    max_connections => 99,
    log_verbosity => 1024
  }
  ->

  exec {'empty log and restart':
    command => 'rm -f /var/log/memcached.log && /etc/init.d/memcached restart',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
