node default {

  user { ['foo', 'bar']:
    ensure     => present,
    system     => false,
  }

  class { 'postfix':
    aliases => {
      'foo'  => 'bar',
    },
  }

  exec { "send mail to user foo":
    provider    => shell,
    command     => 'echo "test" | mail -s "Test" foo',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    timeout     => 30,
    user        => 'foo',
    require     => [User ['foo', 'bar'], Class['postfix']],
  }
}
