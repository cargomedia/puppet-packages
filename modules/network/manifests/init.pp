class network {

  $network = hiera_hash('network', {})

  create_resources('network::interface::static', $network['interfaces'])
  create_resources('network::host', $network['hosts'])
  create_resources('network::resolv', $network['resolv'])
}
