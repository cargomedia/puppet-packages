node default {

  require 'monit'

  class { 'bipbip':
    frequency => 5,
    tags      => ['foo', 'bar'],
  }

  @bipbip::entry { 'memcache':
    plugin  => 'memcached',
    options => {
      'hostname' => 'localhost',
      'port' => '6379'
    }
  }
}
