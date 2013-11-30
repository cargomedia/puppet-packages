node default {

  class {'jenkins':
    hostname => 'example.com'
  }

  class {'jenkins::plugin::ghprb':
    accessToken => 'xxx',
    adminList => ['foo', 'bar']
  }
}
