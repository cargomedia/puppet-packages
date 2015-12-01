node default {

  class { 'janus::transport::http':
    port => 1337,
  }

  class { 'janus::transport::websockets':
    ws_port => 7017,
  }
}
