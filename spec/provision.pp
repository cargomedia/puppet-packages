node default {

  require 'apt::update'

  class {'polipo':
    diskCacheRoot => '/tmp/proxy-cache',
  }

  class {'puppet::common':}
}
