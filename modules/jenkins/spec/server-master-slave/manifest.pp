node default {

  class { 'jenkins':
    hostname   => 'example.com',
    cluster_id => 'foo',
  }

  jenkins::config::slave { 'slave-1':
    cluster_id    => 'foo',
    host          => 'localhost',
    num_executors => 1,
  }

}
