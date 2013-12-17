node default {

  class {'mysql::server::master':
    server_id => '123',
  }
}
