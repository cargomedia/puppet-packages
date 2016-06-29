define janus::role::rtpbroadcast (
  $hostname,
  $bind_address = undef,
  $nat_1_1_mapping = undef,
  $rtp_port_range_min = 20000,
  $rtp_port_range_max = 25000,
  $core_dump = true,
  $http_port = 8300,
  $http_base_path = '/janus',
  $ws_port = 8310,
  $rtpb_minport = 8000,
  $rtpb_maxport = 9000,
  $recording_enabled = false,
  $mountpoint_info_interval = 10,
  $recording_pattern = 'rec-#{id}-#{time}-#{type}',
  $thumbnailing_pattern = 'thum-#{id}-#{time}-#{type}',
  $thumbnailing_interval = 60,
  $thumbnailing_duration = 10,
  $job_pattern = 'job-#{md5}',
  $jobs_path = undef,
  $rest_url = undef,
) {

  include 'janus::cluster'

  janus::server { $name:
    prefix             => $janus::cluster::prefix,
    bind_address       => $bind_address,
    rtp_port_range_min => $rtp_port_range_min,
    rtp_port_range_max => $rtp_port_range_max,
    nat_1_1_mapping    => $nat_1_1_mapping,
    core_dump          => $core_dump,
  }

  janus::transport::http { $name:
    prefix            => $janus::cluster::prefix,
    port              => $http_port,
    http_base_path    => $http_base_path
  }

  janus::transport::websockets { $name:
    prefix     => $janus::cluster::prefix,
    ws_port    => $ws_port,
  }

  $rest_url_final = $rest_url ? { undef => "http://localhost:${http_port}${http_base_path}", default => $rest_url }

  janus::plugin::rtpbroadcast { $name:
    hostname                 => $hostname,
    prefix                   => $janus::cluster::prefix,
    minport                  => $rtpb_minport,
    maxport                  => $rtpb_maxport,
    mountpoint_info_interval => $mountpoint_info_interval,
    recording_enabled        => $recording_enabled,
    thumbnailing_duration    => $thumbnailing_duration,
    thumbnailing_interval    => $thumbnailing_interval,
    thumbnailing_pattern     => $thumbnailing_pattern,
    recording_pattern        => $recording_pattern,
    job_pattern              => $job_pattern,
    jobs_path                => $jobs_path,
    rest_url                 => $rest_url_final,
  }
}
