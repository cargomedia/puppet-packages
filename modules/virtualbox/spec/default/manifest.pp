node default {

  Package {
    install_options => ['-o', 'Acquire::http::Proxy=""'],
  }

  class { 'virtualbox':
  }
}
