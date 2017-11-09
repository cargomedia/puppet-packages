class network {

  $hosts = lookup('network::hosts', Hash, 'deep', { })
  create_resources('network::host', $hosts)

  $routes = lookup('network::routes', Hash, 'deep', { })
  create_resources('network::route', $routes)

  Network::Host <<| |>>
}
