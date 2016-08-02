node default {

  Janus::Server {
    log_level => 5,
  }

  $instances = {
    'repeater1' => {
      hostname            => 'repeater1.us.example.com',
      ws_port             => 10000,
      http_port           => 8300,
      rtp_port_range_min  => 10010,
      rtp_port_range_max  => 14999,
      rtpb_minport        => 18000,
      rtpb_maxport        => 20000,
    },
    'repeater1-multiedge1' => {
      hostname            => 'multiedge1.repeater1.us.example.com',
      ws_port             => 10001,
      http_port           => 9300,
      rtp_port_range_min  => 15000,
      rtp_port_range_max  => 19999,
      rtpb_minport        => 20001,
      rtpb_maxport        => 22000,
    }
  }

  create_resources('janus::role::rtpbroadcast', $instances, { core_dump => false })
}
