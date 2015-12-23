class coturn (
  $port = 3478,
  $port_alt = 0,
  $listening_ip = ['127.0.0.1'],
  $relay_ip = [],
  $external_ip = [],
  $no_multicast_peers = true,
  $mice = false,
) {

  require 'apt'
  require 'apt::source::cargomedia'

  file { '/etc/turnserver.conf':
    ensure  => file,
    content => template("${module_name}/config"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['coturn'],
  }
  ->

  package { 'coturn':
    provider => 'apt',
  }
  ->

  daemon { 'coturn':
    binary => '/usr/bin/turnserver',
    args   => '-c /etc/turnserver.conf -o -v --pidfile /var/run/coturn.pid',
    user   => 'turnserver',
  }
}
