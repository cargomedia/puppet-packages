node default {

  class { ['janus', 'janus::transport::http', 'janus::transport::websockets']: }

  ufw::rule { 'ssh':
    app_or_port => 22,
  }

  include 'ufw'
}
