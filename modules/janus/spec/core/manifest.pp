node default {

  include 'monit'
  include 'bipbip'

  $prefix = '/opt/janus-cluster'

  $orgin_name = 'origin'
  $edge1_name = 'edge1'
  $edge2_name = 'edge2'
  $edge3_name = 'edge3'

  janus::core::janus { $orgin_name:
    prefix => $prefix
  }

# edge cores

  janus::core::janus { $edge1_name:
    prefix => $prefix
  }

  janus::core::janus { $edge2_name:
    prefix => $prefix
  }

  janus::core::janus { $edge3_name:
    prefix => $prefix
  }

# edge transports

  janus::transport::http { $edge1_name:
    prefix   => $prefix,
  }

  janus::transport::websockets { $edge1_name:
    prefix   => $prefix,
    ws_port  => 10001,
  }

  janus::transport::http { $edge2_name:
    prefix   => $prefix,
  }

  janus::transport::websockets { $edge2_name:
    prefix   => $prefix,
    ws_port  => 10002,
  }

  janus::transport::websockets { $edge3_name:
    prefix   => $prefix,
    ws_port  => 10003,
  }

# edge plugins

  janus::plugin::rtpbroadcast { $edge2_name:
    prefix   => $prefix,
  }

  janus::plugin::audioroom { $edge1_name:
    prefix   => $prefix,
  }

  janus::plugin::audioroom { $edge3_name:
    prefix   => $prefix,
  }

  janus::plugin::rtpbroadcast { $edge3_name:
    prefix   => $prefix,
  }
}
