node default {

  class {'jenkins::slave':
    clusterId => 'foo'
  }
}
