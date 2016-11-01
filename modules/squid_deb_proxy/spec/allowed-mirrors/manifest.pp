node default {

  include 'squid_deb_proxy'

  @squid_deb_proxy::allowed_mirrors { '20-test':
    mirrorList => [
      'foo.com',
      'example.com'
    ]
  }
}
