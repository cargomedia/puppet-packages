node default {

  class {'jenkins':
    hostname => 'example.com'
  }

  class {'jenkins::plugin::github':
    oauth_access_token => 'foo',
  }
}
