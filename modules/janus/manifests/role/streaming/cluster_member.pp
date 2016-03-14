define janus::role::streaming::cluster_member (
  $bind_address = undef,
  $token_auth = 'no',
  $api_secret = undef,
  $rtp_port_range_min = 20000,
  $rtp_port_range_max = 25000,
  $nat_1_1_mapping = undef,
  $core_dump = true,
  $http_port = 8300,
  $http_base_path = '/janus',
  $http_admin_base_path = '/janus',
  $http_acl = undef,
  $http_admin_acl = '127.',
  $http_secure_port = 8301,
  $http_admin_port = 8302,
  $http_admin_secure_port = 8303,
  $ws_port = 8310,
  $ws_logging = 0,
  $ws_acl = undef,
  $rtpb_minport = 8000,
  $rtpb_maxport = 9000,
  $rtpb_source_avg_time = 10,
  $rtpb_switching_delay = 1,
  $rtpb_session_info_update_time = 10,
  $rtpb_keyframe_distance_alert = 600,
  $rest_url = undef,
) {

  include 'janus::cluster'

  janus::server { $name:
    prefix             => $janus::cluster::prefix,
    bind_address       => $bind_address,
    token_auth         => $token_auth,
    api_secret         => $api_secret,
    rtp_port_range_min => $rtp_port_range_min,
    rtp_port_range_max => $rtp_port_range_max,
    nat_1_1_mapping    => $nat_1_1_mapping,
    core_dump          => $core_dump,
  }

  janus::transport::http { $name:
    prefix            => $janus::cluster::prefix,
    port              => $http_port,
    http_base_path    => $http_base_path,
    admin_base_path   => $http_admin_base_path,
    acl               => $http_acl,
    admin_acl         => $http_admin_acl,
    secure_port       => $http_secure_port,
    admin_port        => $http_admin_port,
    admin_secure_port => $http_admin_secure_port,
  }

  janus::transport::websockets { $name:
    prefix     => $janus::cluster::prefix,
    ws_port    => $ws_port,
    ws_logging => $ws_logging,
    ws_acl     => $ws_acl,
  }

  $rest_url_final = $rest_url ? { undef => "http://localhost:${http_port}${http_base_path}", default => $rest_url }

  janus::plugin::rtpbroadcast { $name:
    prefix                   => $janus::cluster::prefix,
    minport                  => $rtpb_minport,
    maxport                  => $rtpb_maxport,
    source_avg_time          => $rtpb_source_avg_time,
    switching_delay          => $rtpb_switching_delay,
    session_info_update_time => $rtpb_session_info_update_time,
    keyframe_distance_alert  => $rtpb_keyframe_distance_alert,
    recording_enabled        => false,
    rest_url                 => $rest_url_final,
  }
}
