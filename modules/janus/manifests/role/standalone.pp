define janus::role::standalone (
  $bind_address = undef,
  $token_auth = 'no',
  $api_secret = undef,
  $rtp_port_range_min = 20000,
  $rtp_port_range_max = 25000,
  $stun_server = undef,
  $stun_port = 3478,
  $turn_server = undef,
  $turn_port = 3479,
  $turn_type = 'udp',
  $turn_user = 'myuser',
  $turn_pwd = 'mypassword',
  $nat_1_1_mapping = undef,
  $turn_rest_api = undef,
  $turn_rest_api_key = undef,
  $core_dump = true,
  $ssl_cert = undef,
  $ssl_key = undef,

  $transport_ws_port = 8310,
  $transport_ws_logging = 0,
  $transport_ws_acl = undef,
  $transport_http_port = 8300,
  $transport_http_base_path = '/janus',
  $transport_http_admin_base_path = '/janus',
  $transport_http_acl = undef,
  $transport_http_admin_acl = '127.',
  $transport_http_secure_port = 8301,
  $transport_http_admin_port = 8302,
  $transport_http_admin_secure_port = 8303,

  $plugin_recording_enabled = true,
  $plugin_recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $plugin_thumbnailing_pattern = 'thum-#{id}-#{time}-#{type}',
  $plugin_job_pattern = 'job-#{md5}',
  $plugin_rest_url = undef,
  $plugin_jobs_path = undef,

  $plugin_rtpb_minport = 8000,
  $plugin_rtpb_maxport = 9000,
  $plugin_rtpb_source_avg_time = 10,
  $plugin_rtpb_remb_avg_time = 3,
  $plugin_rtpb_switching_delay = 1,
  $plugin_rtpb_session_info_update_time = 10,
  $plugin_rtpb_keyframe_distance_alert = 600,
  $plugin_rtpb_thumbnailing_interval = 60,
  $plugin_rtpb_thumbnailing_duration = 10,
) {

  include 'janus::cluster'

  janus::server { $title:
    prefix             => $janus::cluster::prefix,
    bind_address       => $bind_address,
    token_auth         => $token_auth,
    api_secret         => $api_secret,
    rtp_port_range_min => $rtp_port_range_min,
    rtp_port_range_max => $rtp_port_range_max,
    stun_server        => $stun_server,
    stun_port          => $stun_port,
    turn_server        => $turn_server,
    turn_port          => $turn_port,
    turn_type          => $turn_type,
    turn_user          => $turn_user,
    turn_pwd           => $turn_pwd,
    nat_1_1_mapping    => $nat_1_1_mapping,
    turn_rest_api      => $turn_rest_api,
    turn_rest_api_key  => $turn_rest_api_key,
    core_dump          => $core_dump,
    ssl_cert           => $ssl_cert,
    ssl_key            => $ssl_key,
  }

  janus::transport::websockets { $title:
    prefix     => $janus::cluster::prefix,
    ws_port    => $transport_ws_port,
    ws_logging => $transport_ws_logging,
    ws_acl     => $transport_ws_acl,
  }

  janus::transport::http { $title:
    prefix            => $janus::cluster::prefix,
    port              => $transport_http_port,
    http_base_path    => $transport_http_base_path,
    admin_base_path   => $transport_http_admin_base_path,
    acl               => $transport_http_acl,
    admin_acl         => $transport_http_admin_acl,
    secure_port       => $transport_http_secure_port,
    admin_port        => $transport_http_admin_port,
    admin_secure_port => $transport_http_admin_secure_port,
  }

  $rec_enabled = $plugin_recording_enabled ? {
    false => 'no',
    default => 'yes'
  }

  $rest_url = $plugin_rest_url ? { undef => "http://localhost:${transport_http_port}${transport_http_base_path}", default => $plugin_rest_url }

  janus::plugin::audioroom { $title:
    prefix            => $janus::cluster::prefix,
    recording_enabled => $rec_enabled,
    recording_pattern => $plugin_recording_pattern,
    job_pattern       => $plugin_job_pattern,
    jobs_path         => $plugin_jobs_path,
    rest_url          => $rest_url,
  }

  janus::plugin::rtpbroadcast { $title:
    prefix                   => $janus::cluster::prefix,
    minport                  => $plugin_rtpb_minport,
    maxport                  => $plugin_rtpb_maxport,
    source_avg_time          => $plugin_rtpb_source_avg_time,
    switching_delay          => $plugin_rtpb_switching_delay,
    session_info_update_time => $plugin_rtpb_session_info_update_time,
    keyframe_distance_alert  => $plugin_rtpb_keyframe_distance_alert,
    recording_enabled        => $rec_enabled,
    recording_pattern        => $plugin_recording_pattern,
    job_pattern              => $plugin_job_pattern,
    jobs_path                => $plugin_jobs_path,
    thumbnailing_duration    => $plugin_rtpb_thumbnailing_duration,
    thumbnailing_interval    => $plugin_rtpb_thumbnailing_interval,
    thumbnailing_pattern     => $plugin_thumbnailing_pattern,
    rest_url                 => $rest_url,
  }
}
