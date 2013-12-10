node default {

  require 'monit'

  class {'bipbip':
    api_key => 'mykey',
    frequency => 5,
  }

  @bipbip::entry {'memcache':
    plugin => 'memcached',
    options => {
      'hostname' => 'localhost',
      'port' => '6379'
    }
  }
}
