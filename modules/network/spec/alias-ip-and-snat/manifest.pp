node default {

  require 'network'

  network::snat { 'Modify source ip for outgoing traffic on all interfaces':
    interface => 'lo',
    source_address => '192.168.20.122',
  }

  exec { 'Start listening on 1337':
    command     => 'nc -lvnp 1337 -s 10.10.20.122 2>/tmp/stderr_output &',
    user        => 'root',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
  }
}
