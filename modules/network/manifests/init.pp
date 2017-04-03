class network {

  require 'network::interfaces_backup'

  $interfaces = lookup('network::interfaces', Hash, 'deep', { })
  create_resources('network::interface', $interfaces)

  $hosts = lookup('network::hosts', Hash, 'deep', { })
  create_resources('network::host', $hosts)

  Network::Host <<| |>>
}
