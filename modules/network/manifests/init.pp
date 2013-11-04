class network  {

  $interfaces = hiera_hash('network::interface')
  create_resources('network::interface::static', $interfaces)

  $hosts = hiera_hash('network::hosts')
  create_resources('network::host', $hosts)

  $resolvs = hiera_hash('network::resolv')
  create_resources('network::resolv', $resolvs)
}
