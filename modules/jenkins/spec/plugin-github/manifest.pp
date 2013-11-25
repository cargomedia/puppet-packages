node default {

  class {'jenkins':
    hostname => 'example.com'
  }

  class {'jenkins::plugin::github':
    oauthAccessToken => 'foo',
  }
}
