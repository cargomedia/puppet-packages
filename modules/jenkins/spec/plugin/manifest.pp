node default {

  class { 'jenkins':
    hostname => 'example.com'
  }

  jenkins::plugin { 'avatar':
    version => '1.2',
  }

  jenkins::plugin { 'pagerduty':
    version => '0.2.4',
  }

}
