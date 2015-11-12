node default {

  class { 'janus::plugin::audioroom': }
  class { 'janus::plugin::rtpbroadcast': }

}
