node default {

  class {'jenkins':}

  jenkins::plugin {'ssh-agent':
    version => '1.3',
  }

  jenkins::plugin {'git-client':
    version => '1.2.0',
  }
}
