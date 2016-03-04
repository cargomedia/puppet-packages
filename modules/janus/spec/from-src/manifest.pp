node default {

  janus::plugin::rtpbroadcast { 'from-src': }
  janus::core::janus { 'from-src': }
  janus::transport::websockets { 'from-src': }
  janus::plugin::audioroom { 'from-src': }

}
