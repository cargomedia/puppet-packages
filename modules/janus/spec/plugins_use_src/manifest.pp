node default {

  class { ['janus::plugin::audioroom', 'janus::plugin::rtpbroadcast']:
    src_version => 'v0.0.4', }

}
