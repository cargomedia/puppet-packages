node default {

  class {'jenkins':
    hostname => 'example.com'
  }

  class {'jenkins::plugin::git':
    globalConfigName => 'foo',
    globalConfigEmail => 'bar@example.com',
  }
}
