node default {

  class { ['janus', 'janus::transport::http', 'janus::transport::websockets']: }

  include 'ufw'
}
