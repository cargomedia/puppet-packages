node default {
# hack to bypass proxy

  Package {
    install_options => ['-o', 'Acquire::Retries=20'],
  }

  class { 'puppet::db':
    port     => 8080,
    port_ssl => 8081,
  }

}
