node default {

  class {'jenkins':
    hostname => 'example.com'
  }

  jenkins::plugin {'ssh-agent':
    version => '1.3',
  }

  jenkins::plugin {'git-client':
    version => '1.2.0',
  }
}
