node default {

  class { 'jenkins':
    hostname => 'example.com'
  }

  jenkins::plugin { 'pagerduty':
    version => '0.2.4',
  }

  class { 'jenkins::plugin::git':
    global_config_name  => 'foo',
    global_config_email => 'bar@example.com',
  }

  class { 'jenkins::plugin::github':
    oauth_access_token => 'foo',
  }

  class { 'jenkins::plugin::ghprb':
    access_token => 'xxx',
    admin_list   => ['foo', 'bar']
  }

  class { 'jenkins::plugin::ansicolor':
  }

  class { 'jenkins::plugin::embeddable_build_status':
  }

}
