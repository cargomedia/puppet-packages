node default {

  include 'monit'
  include 'bipbip'

  #
  # # defaults
  $origin_name = 'origin'
  $edge1_name = 'edge1'
  $edge2_name = 'edge2'
  $edge3_name = 'edge3'
  $cluster_base_dir = '/opt/janus-cluster'

  Janus::Core::Janus {
    prefix => $cluster_base_dir,
  }

  Janus::Transport::Websockets {
    prefix => $cluster_base_dir,
  }

  Janus::Transport::Http {
    prefix => $cluster_base_dir,
  }

  Janus::Plugin::Audioroom {
    prefix => $cluster_base_dir,
  }

  Janus::Plugin::Rtpbroadcast {
    prefix => $cluster_base_dir,
  }

  service{ 'janus':
    ensure => stopped,
  }

    #
  # # origin node
  janus::core::janus { $origin_name: }

  janus::transport::websockets { $origin_name:
    ws_port  => 10000,
  }

  janus::transport::http { $origin_name:
    port  => 8000,
  }
  #
  #  # 1st edge node
  janus::core::janus { $edge1_name: }

  janus::transport::http { $edge1_name:
    port => 8001,
  }

  janus::transport::websockets { $edge1_name:
    ws_port  => 10001,
  }

  janus::plugin::audioroom { $edge1_name:
    rest_url => 'http://127.0.0.1:8001/janus',
  }

  #  #
  #  #  2nd edge node
  janus::core::janus { $edge2_name: }

  janus::transport::http { $edge2_name:
    port => 8002,
  }

  janus::plugin::audioroom { $edge2_name:
    rest_url => 'http://127.0.0.1:8002/janus',
  }

  #  #
  #  #  3rd edge node
  janus::core::janus { $edge3_name: }

  janus::transport::websockets { $edge3_name:
    ws_port  => 10003,
  }

  janus::transport::http { $edge3_name:
    port => 8003,
  }

  janus::plugin::rtpbroadcast { $edge3_name:
    rest_url => 'http://127.0.0.1:8003/janus',
  }
}
