node default {

  include 'monit'
  include 'bipbip'

  $origin_name = 'origin'
  $edge1_name = 'edge1'
  $edge2_name = 'edge2'
  $edge3_name = 'edge3'

  # origin node
  janus::core::janus { $origin_name:
    origin => true,
  }

  # 1st edge node
  janus::core::janus { $edge1_name: }

  janus::transport::http { $edge1_name:
    port => 8000,
  }

  janus::transport::websockets { $edge1_name:
    ws_port  => 10001,
  }

  janus::plugin::audioroom { $edge1_name:
    rest_url => 'http://127.0.0.1:8000/janus',
  }

  #
  #  3rd edge node
  #}
  #
    janus::core::janus { $edge3_name: }

    janus::transport::websockets { $edge3_name:
      ws_port  => 10003,
    }

  #  janus::plugin::audioroom { $edge3_name:
  #    prefix   => "${prefix}/${edge3_name}",
  #  }

  #  janus::plugin::rtpbroadcast { $edge3_name:
  #    prefix   => "${prefix}/${edge3_name}",
  #  }
}
