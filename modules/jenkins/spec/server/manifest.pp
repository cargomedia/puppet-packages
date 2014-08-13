node default {

  require 'monit'

  class {'jenkins':
    hostname => 'example.com',
    port => 1234
  }
}
