node default {

  environment::variable { ['http_proxy', 'HTTP_PROXY']:
    value => '',
  }
  ->

  class { 'puppet::db':
    port     => 8080,
    port_ssl => 8081,
  }

}
