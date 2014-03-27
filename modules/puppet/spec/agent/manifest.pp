node default {

  class {'puppet::agent':
    server => 'example.com',
    masterport => 8141,
    runinterval => '2m',
  }

}
