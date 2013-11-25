node default {

  class {'jenkins':
    hostname => 'example.com'
  }

  jenkins::job {'foo':
    content => 'foo',
  }

  jenkins::job {'bar':
    content => 'bar',
  }
}
