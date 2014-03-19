node default {

  class {'puppet::master':
    port_webrick => 8139,
    port_passenger => 8141,
  }

}
