node default {

  include 'network::nat'

  exec { 'Start listening on 1337':
    command     => 'nc -lvnp 1337 -s 127.0.0.1 2>/tmp/stderr_output &',
    user        => 'root',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
  }
}
