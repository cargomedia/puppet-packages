node default {

  cm::services::janus { 'standalone':
    hostname              => 'foohost',
    http_server_api_key   => 'janus-fish',
    http_server_port      => 8100,
    websocket_server_port => 8110,

    cm_application_path   => '/home/cm',
    cm_api_base_url       => 'http://www.cm.dev',
    cm_api_key            => 'cm-fish',

    rtpbroadcast_minport  => 10000,
    rtpbroadcast_maxport  => 15000,
  }

  include 'ufw'

}
