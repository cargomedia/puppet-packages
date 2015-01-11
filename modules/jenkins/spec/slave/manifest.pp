node default {

  class {'jenkins::slave':
    cluster_id => 'foo'
  }
}
