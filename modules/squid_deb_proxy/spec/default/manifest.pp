node default {

  class { 'squid_deb_proxy':
    diskCacheRoot => '/var/cache/polipo',
  }
}
