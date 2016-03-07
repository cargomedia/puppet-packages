class network {

  require 'network::interfaces_backup'

  $interfaces = hiera_hash('network::interfaces', { })
  create_resources('network::interface', $interfaces)

  $hosts = hiera_hash('network::hosts', { })
  create_resources('network::host', $hosts)

  Network::Host <<| |>>
}
