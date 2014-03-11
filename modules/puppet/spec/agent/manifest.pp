node default {

  class {'puppet::agent':
    server => 'example.com',
    runinterval => '2m',
  }

}
