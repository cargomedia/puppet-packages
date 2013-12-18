node default {

  class {'mysql::server::slave':
    cluster_name => 'foo',
    server_id => '321',
  }
}
