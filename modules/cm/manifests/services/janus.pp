class cm::services::janus(
  $hostname,
  $http_server_api_key,
  $http_server_port = 8100,
  $websocket_server_port = 8110,

  $ssl_cert = undef,
  $ssl_key = undef,

  $cm_application_path,
  $cm_api_base_url,
  $cm_api_key,

  $rtpbroadcast_minport = 8400,
  $rtpbroadcast_maxport = 9000,
) {

  class { 'janus::transport::http':
    base_path          => '/janus',
    threads            => 'unlimited',
    http               => 'yes',
    port               => 8300,
    https              => 'no',
    secure_port        => 8301,
    acl                => '127.',
    admin_base_path    => '/admin',
    admin_threads      => 'unlimited',
    admin_http         => 'yes',
    admin_port         => 8302,
    admin_https        => 'no',
    admin_secure_port  => 8303,
    admin_acl          => '127.',
  }

  class { 'janus::transport::websockets':
    ws_port => 8310,
    ws_acl  => '127.',
  }

  class { 'janus::plugin::audioroom': }
  class { 'janus::plugin::rtpbroadcast':
    minport => $rtpbroadcast_minport,
    maxport => $rtpbroadcast_maxport,
  }

  class { 'cm_janus':
    http_server_port           => $http_server_port,
    http_server_api_key        => $http_server_api_key,
    websockets_listen_port     => 8210,
    websockets_janus_address   => 'ws://localhost:8120/janus',
    cm_api_base_url            => $cm_api_base_url,
    cm_api_key                 => $cm_api_key,
    cm_application_path        => $cm_application_path,
    jobs_path                  => '/var/lib/janus/jobs',
    require                    => Service['janus'],
  }
  ->

  class { 'cm_janus::proxy':
    hostname  => $hostname,
    port      => $websocket_server_port,
    ssl_key   => $ssl_key,
    ssl_cert  => $ssl_cert,
  }
}
