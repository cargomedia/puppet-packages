node default {

  require 'monit'

  class { 'cm_janus':
    http_server_port =>  8800,
    http_server_api_key =>  'foobar23',
    cm_api_base_url => 'foo',
  }
}
