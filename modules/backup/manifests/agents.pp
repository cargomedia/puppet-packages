class backup::agents {

  $agents = hiera_hash('backup::agents', {})
  create_resources('backup::agent', $agents)
}
