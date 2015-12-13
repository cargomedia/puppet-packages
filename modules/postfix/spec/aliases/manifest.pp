node default {

  user { ['foo', 'bar']:
    ensure     => present,
    system     => false,
  }
  ->

  class { 'postfix':
    aliases => {
      'foo'  => 'bar',
    },
  }
  ->

  exec { 'send mail to user foo':
    provider    => shell,
    command     => 'echo "test" | mail -s "Test" foo',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  exec { 'send mail to user root':
    provider    => shell,
    command     => 'echo "test" | mail -s "Test" root',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
}
