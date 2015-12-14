node default {

  host { ['localhost']:
    ip => '127.0.0.2',
  }

  class { 'postfix':
    transports => [
      {
        'filter'      => '/^To: filter_11101/',
        'protocol'    => 'smtp',
        'host'        => '127.0.0.1',
        'port'        => '11101',
        'credentials' => 'foo:bar',
      },
      {
        'filter'      => '/^To: filter_11102/',
        'protocol'    => 'smtp',
        'host'        => '127.0.0.2',
        'port'        => '11102',
        'credentials' => 'bar:foo',
      }
    ],
  }

  exec { 'smtp-sink instance #1':
    provider    => shell,
    command     => '(sudo smtp-sink -vu postfix 127.0.0.1:11101 10 2>&1 | tee /tmp/11101)&',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Class['postfix'],
  }

  exec { 'smtp-sink instance #2':
    provider    => shell,
    command     => '(sudo smtp-sink -vu postfix 127.0.0.2:11102 10 2>&1 | tee /tmp/11102)&',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Class['postfix'],
  }

  exec { 'send test mail #1':
    provider    => shell,
    command     => 'echo "test" | mail -s "test" filter_11101@example.com',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Exec['smtp-sink instance #1'],
  }

  exec { 'send test mail #2':
    provider    => shell,
    command     => 'echo "test" | mail -s "test" filter_11102@example.com',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Exec['smtp-sink instance #2'],
  }
}
