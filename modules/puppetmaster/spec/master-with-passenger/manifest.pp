node default {

  class { 'puppetmaster':
    port_webrick   => 8139,
    port_passenger => 8141,
  }

}
