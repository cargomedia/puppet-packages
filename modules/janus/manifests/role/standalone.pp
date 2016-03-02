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
  $ws_port = 8310,
  $ws_logging = 0,
  $ws_acl = undef,
  $http_port = 8300,
  $https = false,
  $https_port = 8301,
  $http_base_path = '/janus',
  $recording_enabled = true,
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $job_pattern = 'job-#{md5}',
)

  # core
  # ws transport
  # http transport
  # rtp plugin
  # audio plugin
  # ufw
  # bipbip
  # cm-janus
  # cm-janus-proxy


{

  janus::core::janus { $title:
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
    ws_port    => $ws_port,
    ws_logging => $ws_logging,
    ws_acl     => $ws_acl,
  }

  if $https {
    $https_arg = 'yes'
    $rest_protocol = 'https'
    $rest_port = $https_port
  } else {
    $https_arg = 'no'
    $rest_protocol = 'http'
    $rest_port = $http_port
  }
  $rest_base_path = "${http_base_path}-${title}"

  janus::transport::http { $title:
    port           => 8300,
    http_base_path => $rest_base_path,
    https          => $https_arg,
    secure_port    => 8343,
  }

  $rec_enabled = $recording_enabled ? {
    false => 'no',
    default => 'yes'
  }

  janus::plugin::audioroom { $title:
    recording_enabled => $rec_enabled,
    recording_pattern => $recording_pattern,
    job_pattern       => $job_pattern,
    rest_url          => "${rest_protocol}://localhost:${rest_port}/${rest_base_path}"
  }



}
