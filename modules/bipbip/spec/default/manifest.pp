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
