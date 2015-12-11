node default {

  Package {
    install_options => ['-o', 'Acquire::http::Proxy=""'],
  }

  class { 'puppetmaster::puppetdb':
    port     => 8080,
    port_ssl => 8081,
  }

}
