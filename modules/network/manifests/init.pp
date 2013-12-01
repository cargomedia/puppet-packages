class network(
  $fqdn
) {

  class{'network::hostname':
    fqdn => $fqdn,
  }

  $interfaces = hiera_hash('network::interfaces', {})
  create_resources('network::interface', $interfaces)

  $hosts = hiera_hash('network::hosts', {})
  create_resources('network::host', $hosts)
}
