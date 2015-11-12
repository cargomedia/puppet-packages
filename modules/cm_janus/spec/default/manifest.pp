node default {

  require 'monit'

  class { 'cm_janus':
    http_server_port =>  8800,
    server_key =>  'foo23',
    cm_api_base_url => 'http://www.example.com',
  }
}
