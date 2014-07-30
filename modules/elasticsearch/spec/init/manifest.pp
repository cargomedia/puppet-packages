node default {

  class {'elasticsearch':
    publish_host => 'localhost',
    heap_size => '123m',
    cluster_name => 'foo',
  }
}
