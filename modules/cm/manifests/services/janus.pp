class cm::services::janus(
  $hostname = 'localhost',
  $http_server_api_key = 'secret-monkey',
  $http_server_port = 8100,
  $websocket_server_port = 8110,

  $ssl_cert = undef,
  $ssl_key = undef,

  $cm_application_path = '/home/apps/cm',
  $cm_api_base_url = 'http://www.cm.dev',
  $cm_api_key = 'mad-panda',

  $webrtc_media_minport = 20000,
  $webrtc_media_maxport = 25000,
  $rtpbroadcast_minport = 8400,
  $rtpbroadcast_maxport = 9000,

  $recording_enabled = 'yes',
  $ufw_app_profile = undef,
) {

  $janus_http_port = 8300
  $janus_websockets_port = 8310

  class { '::janus':
    bind_address       => '127.0.0.1',
    rtp_port_range_min => $webrtc_media_minport,
    rtp_port_range_max => $webrtc_media_maxport,
  }

  class { 'janus::transport::http':
    base_path          => '/janus',
    threads            => 'unlimited',
    http               => 'yes',
    port               => $janus_http_port,
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
    ws_port => $janus_websockets_port,
    ws_acl  => '127.',
  }

  class { 'janus::plugin::audioroom':
    recording_enabled => $recording_enabled,
  }
  class { 'janus::plugin::rtpbroadcast':
    minport => $rtpbroadcast_minport,
    maxport => $rtpbroadcast_maxport,
    recording_enabled => $recording_enabled,
  }

  class { 'cm_janus':
    http_server_port           => $http_server_port,
    http_server_api_key        => $http_server_api_key,
    websockets_listen_port     => 8210,
    janus_websocket_address    => "ws://localhost:${janus_websockets_port}/janus",
    janus_http_address         => "http://localhost:${janus_http_port}/janus",
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

  $ufw_default_tcp = "${http_server_port},${websocket_server_port},${webrtc_media_minport}:${webrtc_media_maxport}/tcp"
  $ufw_default_udp = "${webrtc_media_minport}:${webrtc_media_maxport},${rtpbroadcast_minport}:${rtpbroadcast_maxport}/udp"

  $ufw_rule = $ufw_app_profile ? {
    undef => "${ufw_default_tcp}|${ufw_default_udp}",
    default => $ufw_app_profile,
  }

  @ufw::application { 'cm-janus':
    app_ports       => $ufw_rule,
  }
}
