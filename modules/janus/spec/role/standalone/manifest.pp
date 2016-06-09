node default {

  Janus::Server {
    log_level => 4,
  }

  $instances = {
    'instance1' => {
      hostname                          => 'instance1.example.com',
      rtp_port_range_min                => 10010,
      rtp_port_range_max                => 14999,
      transport_ws_port                 => 10000,
      transport_http_port               => 8300,
      transport_http_secure_port        => 8301,
      transport_http_admin_port         => 8302,
      transport_http_admin_secure_port  => 8303,
      plugin_rtpb_minport               => 18000,
      plugin_rtpb_maxport               => 20000,
    },
    'instance2' => {
      hostname                          => 'instance2.example.com',
      rtp_port_range_min                => 15000,
      rtp_port_range_max                => 19999,
      transport_ws_port                 => 10001,
      transport_http_port               => 9300,
      transport_http_secure_port        => 9301,
      transport_http_admin_port         => 9302,
      transport_http_admin_secure_port  => 9303,
      plugin_rtpb_minport               => 20001,
      plugin_rtpb_maxport               => 22000,
    }
  }

  create_resources('janus::role::standalone', $instances, { core_dump => false })
}
