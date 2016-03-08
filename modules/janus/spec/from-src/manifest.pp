node default {

  janus::core::janus { 'from-src': }
  janus::transport::websockets { 'from-src': }
  janus::plugin::rtpbroadcast { 'from-src': }
  janus::plugin::audioroom { 'from-src': }

}
