node default {

  include 'bipbip'
  include 'mysql::server'

  class { 'mysql::server::slave':
    replication_id => 'f00',
    server_id      => '99',
  }
}
