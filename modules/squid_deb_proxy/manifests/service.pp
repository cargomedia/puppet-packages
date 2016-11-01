class squid_deb_proxy::service {

  require 'squid_deb_proxy'

  service { 'squid-deb-proxy':
    enable => true,
  }

}
