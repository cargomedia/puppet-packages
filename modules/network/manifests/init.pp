class network {

  exec { 'Backup existing network config':
    provider => shell,
    command  => 'cp /etc/network/interfaces /etc/network/interfaces.provisioned',
    unless   => 'ls /etc/network/interfaces.provisioned',
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user     => 'root',
  }

  $interfaces = hiera_hash('network::interfaces', { })
  create_resources('network::interface', $interfaces)

  $hosts = hiera_hash('network::hosts', { })
  create_resources('network::host', $hosts)

  Network::Host <<| |>>
}
