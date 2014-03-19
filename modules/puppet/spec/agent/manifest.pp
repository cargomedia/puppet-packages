node default {

  class {'puppet::agent':
    server => 'example.com',
    port => 8141,
    runinterval => '2m',
  }

}
