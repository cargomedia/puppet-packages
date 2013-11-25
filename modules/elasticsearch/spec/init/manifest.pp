node default {

  class {'monit':}

  class {'elasticsearch':
    publish_host => 'localhost',
    heap_size => '512m',
    cluster_name => 'foo',
  }
}
