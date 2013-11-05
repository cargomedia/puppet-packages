class network($config = undef) {

  if !$config {
    $config = hiera_hash('network', {})
  }

  create_resources('network::interface::static', $config['interfaces'])
  create_resources('network::host', $config['hosts'])
  create_resources('network::resolv', $config['resolv'])
}
