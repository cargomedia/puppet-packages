node default {

  require 'apt::update'

  class {'polipo':
    diskCacheRoot => '/tmp/http-cache',
  }

  class {'puppet::common':}
}
