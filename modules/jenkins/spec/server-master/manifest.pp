node default {

  class {'jenkins':
    hostname => 'example.com',
    clusterId => 'foo',
  }

}
