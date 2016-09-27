node default {

  require 'network'

  class { 'ufw::nat':
    ifname_public => 'lo',
    ifname_private => 'eth0',
    to_source => '192.168.20.122'
  }

  ufw::rule { 'allow 22 - otherwise tests wont run :)':
    app_or_port => '22',
  }

  exec { 'Start listening on 1337':
    command     => 'nc -lvnp 1337 2>/tmp/stderr_output &',
    user        => 'root',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
  }
}
