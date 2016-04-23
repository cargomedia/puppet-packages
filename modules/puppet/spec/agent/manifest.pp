node default {

  class { 'puppet::agent':
    server      => 'example.com',
    masterport  => 1234,
    runinterval => '2m',
    splay       => true,
    environment => 'foo',
  }

}
