class backup::agents {

  $agents = lookup('backup::agents', { })
  create_resources('backup::agent', $agents)
}
