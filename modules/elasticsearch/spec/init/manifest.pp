node default {

  class {'elasticsearch':
    publish_host => 'localhost',
    heap_size_min => '512m',
    heap_size_max => '1g',
    cluster_name => 'foo',
  }
}
