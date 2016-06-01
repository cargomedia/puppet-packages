node default {

  include 'monit'
  include 'bipbip'
  include 'janus::cluster'

  Janus::Server {
    prefix => $janus::cluster::prefix,
  }

  Janus::Transport::Websockets {
    prefix => $janus::cluster::prefix,
  }

  Janus::Transport::Http {
    prefix => $janus::cluster::prefix,
  }

  Janus::Plugin::Audioroom {
    prefix => $janus::cluster::prefix,
  }

  Janus::Plugin::Rtpbroadcast {
    prefix => $janus::cluster::prefix,
    hostname => '127.0.0.1',
  }

  # origin node
  janus::server { 'origin': }

  janus::transport::websockets { 'origin':
    ws_port  => 10000,
  }

  janus::transport::http { 'origin':
    port  => 8000,
  }

  #  1st edge node
  janus::server { 'edge1': }

  janus::transport::http { 'edge1':
    port => 8001,
  }

  janus::transport::websockets { 'edge1':
    ws_port  => 10001,
  }

  janus::plugin::audioroom { 'edge1':
    rest_url => 'http://127.0.0.1:8001/janus',
  }

  #  2nd edge node
  janus::server { 'edge2': }

  janus::transport::http { 'edge2':
    port => 8002,
  }

  janus::plugin::audioroom { 'edge2':
    rest_url => 'http://127.0.0.1:8002/janus',
  }

  #  3rd edge node
  janus::server { 'edge3': }

  janus::transport::websockets { 'edge3':
    ws_port  => 10003,
  }

  janus::transport::http { 'edge3':
    port => 8003,
  }

  janus::plugin::rtpbroadcast { 'edge3':
    rest_url => 'http://127.0.0.1:8003/janus',
  }
}
