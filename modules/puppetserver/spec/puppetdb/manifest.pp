node default {

  class { 'puppetserver::puppetdb':
    port     => 8080,
    port_ssl => 8081,
  }

}
