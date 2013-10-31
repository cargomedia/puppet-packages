node default {

  class {'networking':
    hosts => ['foobar'],
    ipaddress => '127.0.0.1',
    interfaces => 'foo',
  }
}