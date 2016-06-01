node default {

  require 'monit'

  class { 'jenkins':
    hostname      => 'example.com',
    port          => 1234,
    num_executors => 2,
    email_admin   => 'admin@example.com',
  }
}
