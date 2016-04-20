node default {

  janus::server { 'from-src': }
  janus::transport::websockets { 'from-src': }
  janus::plugin::rtpbroadcast { 'from-src':
    hostname => '127.0.0.1'
  }
  janus::plugin::audioroom { 'from-src': }

}
