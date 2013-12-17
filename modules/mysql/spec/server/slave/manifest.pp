node default {

  class {'mysql::server::slave':
    server_id => '321',
  }
}
