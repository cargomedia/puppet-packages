node default {

  require 'puppet::common'
  require 'apt::update'

  class {'polipo':
    diskCacheRoot => '/tmp/proxy-cache',
    idleTime => 0,
  }
}
