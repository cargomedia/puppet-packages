node default {

  janus::server { 'http': }

  janus::transport::http { 'http':
    port => 1337,
  }

  janus::transport::websockets { 'http':
    ws_port => 7017,
  }
}
