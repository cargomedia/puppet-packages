node default {

  require 'monit'

  class { 'bipbip':
    api_key   => 'mykey',
    frequency => 5,
  }

  @bipbip::entry { 'memcache':
    plugin  => 'memcached',
    options => {
      'hostname' => 'localhost',
      'port' => '6379'
    }
  }

  @bipbip::entry { 'logparser':
    plugin  => 'log-parser',
    options => {
      'path' => '/var/log/syslog',
      'matchers' => [
        { 'name' => 'oom_killer_activity',
          'regexp' => 'invoked oom-killer' },
        { 'name' => 'segfaults',
          'regexp' => 'segfault' }
      ]
    }
  }
}
