class network() {

  $config = hiera_hash('network', {})

  create_resources('network::interface', $config['interfaces'])
  create_resources('network::host', $config['hosts'])
  create_resources('network::resolv', $config['resolv'])
}
