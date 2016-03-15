define cm::services::janus(
  $hostname = 'localhost',
  $http_server_api_key = 'secret-monkey',
  $http_server_port = 8100,
  $websocket_server_port = 8110,
  $nat_1_1_mapping = undef,

  $ssl_cert = undef,
  $ssl_key = undef,

  $cm_application_path = '/home/apps/cm',
  $cm_api_base_url = 'http://www.cm.dev',
  $cm_api_key = 'mad-panda',

  $webrtc_media_minport = 20000,
  $webrtc_media_maxport = 25000,
  $rtpbroadcast_minport = 8400,
  $rtpbroadcast_maxport = 9000,

  $recording_enabled = true,
  $ufw_app_profile = undef,

  $janus_http_port = 8300,
  $janus_websockets_port = 8310,
  $cm_janus_websocket_port = 8210,

  $transport_http_secure_port = 8301,
  $transport_http_admin_port = 8302,
  $transport_http_admin_secure_port = 8303,

  $jobs_path = '/var/lib/janus/jobs'
) {

  include 'cm_janus::cluster'

  ::janus::role::standalone { $title:
    bind_address                     => '127.0.0.1',
    nat_1_1_mapping                  => $nat_1_1_mapping,
    rtp_port_range_min               => $webrtc_media_minport,
    rtp_port_range_max               => $webrtc_media_maxport,

    transport_ws_port                => $janus_websockets_port,
    transport_ws_logging             => 0,
    transport_ws_acl                 => '127.',

    transport_http_port              => $janus_http_port,
    transport_http_base_path         => '/janus',
    transport_http_admin_base_path   => '/admin',
    transport_http_acl               => '127.',
    transport_http_admin_acl         => '127.',
    transport_http_secure_port       => $transport_http_secure_port,
    transport_http_admin_port        => $transport_http_admin_port,
    transport_http_admin_secure_port => $transport_http_admin_secure_port,

    plugin_recording_enabled         => $recording_enabled,
    plugin_rest_url                  => "http://127.0.0.1:${janus_http_port}/janus",
    plugin_jobs_path                 => $jobs_path,

    plugin_rtpb_minport              => $rtpbroadcast_minport,
    plugin_rtpb_maxport              => $rtpbroadcast_maxport,
  }

  cm_janus { $title:
    prefix                     => $cm_janus::cluster::prefix,
    http_server_port           => $http_server_port,
    http_server_api_key        => $http_server_api_key,
    websockets_listen_port     => $cm_janus_websocket_port,
    janus_websocket_address    => "ws://localhost:${janus_websockets_port}/janus",
    janus_http_address         => "http://localhost:${janus_http_port}/janus",
    cm_api_base_url            => $cm_api_base_url,
    cm_api_key                 => $cm_api_key,
    cm_application_path        => $cm_application_path,
    jobs_path                  => $jobs_path,
    require                    => Janus::Role::Standalone[$title],
  }
  ->

  cm_janus::proxy { $title:
    hostname      => $hostname,
    port          => $websocket_server_port,
    upstream_port => $cm_janus_websocket_port,
    ssl_key       => $ssl_key,
    ssl_cert      => $ssl_cert,
  }

  $ufw_default_tcp = "${http_server_port},${websocket_server_port},${webrtc_media_minport}:${webrtc_media_maxport}/tcp"
  $ufw_default_udp = "${webrtc_media_minport}:${webrtc_media_maxport},${rtpbroadcast_minport}:${rtpbroadcast_maxport}/udp"

  $ufw_rule = $ufw_app_profile ? {
    undef => "${ufw_default_tcp}|${ufw_default_udp}",
    default => $ufw_app_profile,
  }

  @ufw::application { "ufw for cm_janus-${title}":
    name            => "cm_janus-${title}",
    app_ports       => $ufw_rule,
  }
}
