node default {

  class { 'postfix':
    transports => [
      {
        'filter'  => '/^To: filter_2525/',
        'protocol' => 'smtp',
        'host' => '127.0.0.1',
        'port' => '2525',
        'credentials' => 'foo:bar',
      },
      {
        'filter'  => '/^To: filter_2828/',
        'protocol' => 'smtp',
        'host' => '127.0.1.1',
        'port' => '2828',
        'credentials' => 'bar:foo',
      }
    ],
  }

  exec { 'smtp-sink instance #1':
    provider    => shell,
    command     => '(sudo smtp-sink -vu postfix 127.0.0.1:2525 10 2>&1 | tee /tmp/2525)&',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Class ['postfix'],
  }

  exec { 'smtp-sink instance #2':
    provider    => shell,
    command     => '(sudo smtp-sink -vu postfix 127.0.1.1:2828 10 2>&1 | tee /tmp/2828)&',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Class ['postfix'],
  }

  exec { 'send test mail #1':
    provider    => shell,
    command     => 'echo "test" | mail -s "test" filter_2525@example.com',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Exec ['smtp-sink instance #1'],
  }

  exec { 'send test mail #2':
    provider    => shell,
    command     => 'echo "test" | mail -s "test" filter_2828@example.com',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Exec ['smtp-sink instance #2'],
  }
}
