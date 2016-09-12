node default {

  require 'network'
  include 'network::nat'

  exec { 'Start listening on 1337':
    command     => 'nc -lvnp 1337 2>/tmp/stderr_output &',
    user        => 'root',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider    => shell,
  }
}
