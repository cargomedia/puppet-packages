node default {

  class {'network::hostname':
    fqdn => 'foo.bar',
  }
}
