class network() {

  $interfaces = hiera_hash('network::interfaces', {})
  create_resources('network::interface', $interfaces)

  $hosts = hiera_hash('network::hosts', {})
  create_resources('network::host', $hosts)

  $resolvs = hiera_hash('network::resolvs', {})
  create_resources('network::resolv', $resolvs)
}
