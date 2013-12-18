node default {

  class {'mysql::server::master':
    cluster_name => 'foo',
    server_id => '123',
  }
}
