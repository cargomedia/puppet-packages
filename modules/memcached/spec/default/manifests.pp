node default {

  require 'monit'

  class {'memcached':
  }
}
