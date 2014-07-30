node default {

  class {'elasticsearch':
    publish_host => 'localhost',
    cluster_name => 'foo',
  }
}
