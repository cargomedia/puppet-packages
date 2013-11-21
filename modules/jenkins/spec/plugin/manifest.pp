node default {

  class {'jenkins':}

  jenkins::plugin {'git':
    version => '1.5.0',
  }

  jenkins::plugin {'ghprb':
    version => '1.9',
  }
}
