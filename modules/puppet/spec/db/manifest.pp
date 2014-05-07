node default {

  class {'puppet::db':
    port => 8080,
    port_ssl => 8081,
  }

}
