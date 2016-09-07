node default {

  class { 'postfix':
    relay =>       {
      'transport'   => 'smtp',
      'host'        => '127.0.0.1',
      'port'        => '2525',
      'credentials' => 'foo:bar',
    },
  }

  exec { 'smtp-sink instance':
    provider    => shell,
    command     => '(sudo smtp-sink -vu postfix 127.0.0.1:2525 10 2>&1 | tee /tmp/2525)&',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Class['postfix'],
  }

  exec { 'send test mail #1':
    provider    => shell,
    command     => 'echo "test" | mail -s "test" filter_2525@example.com',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Exec['smtp-sink instance'],
  }

  exec { 'send test mail #2':
    provider    => shell,
    command     => 'echo "test" | mail -s "test" filter_2828@example.com',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Exec['smtp-sink instance'],
  }
}
