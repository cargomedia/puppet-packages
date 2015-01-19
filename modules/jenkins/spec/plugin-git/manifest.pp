node default {

  class {'jenkins':
    hostname => 'example.com'
  }

  class {'jenkins::plugin::git':
    global_config_name => 'foo',
    global_config_email => 'bar@example.com',
  }
}
