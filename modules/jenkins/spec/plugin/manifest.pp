node default {

  class { 'jenkins':
    hostname => 'example.com'
  }

  jenkins::plugin { 'git':
    version => '2.4.4',
  }

  jenkins::plugin { 'pagerduty':
    version => '0.2.4',
  }

}
