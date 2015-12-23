node default {

  require 'monit'

  class { 'cm_janus':
    http_server_port    =>  8801,
    http_server_api_key =>  'foobar23',
    cm_api_base_url     => 'foo',
    cm_api_key          => 'fish',
    cm_application_path => '/home/cm',
    jobs_path           => '/tmp',
  }
}
