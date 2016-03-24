define janus::role::streaming::edge (
  $rtp_port_range_min = 20000,
  $rtp_port_range_max = 25000,
  $http_port = 8300,
  $ws_port = 8310,
  $rtpb_minport = 8000,
  $rtpb_maxport = 9000,
) {

  janus::role::streaming::cluster_member { $title:
    edge               => true,
    rtp_port_range_min => $rtp_port_range_min,
    rtp_port_range_max => $rtp_port_range_max,
    http_port          => $http_port,
    ws_port            => $ws_port,
    rtpb_minport       => $rtpb_minport,
    rtpb_maxport       => $rtpb_maxport,
  }
}
