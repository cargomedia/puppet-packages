node default {

  require 'monit'

  class {'jenkins':
    hostname => 'example.com'
  }
}
