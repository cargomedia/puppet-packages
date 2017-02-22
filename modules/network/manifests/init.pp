class network {

  require 'network::interfaces_backup'

  $interfaces = lookup('network::interfaces', { })
  create_resources('network::interface', $interfaces)

  $hosts = lookup('network::hosts', { })
  create_resources('network::host', $hosts)

  Network::Host <<| |>>
}
