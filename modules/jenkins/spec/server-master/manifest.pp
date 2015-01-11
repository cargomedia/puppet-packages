node default {

  class {'jenkins':
    hostname => 'example.com',
    cluster_id => 'foo',
  }

}
