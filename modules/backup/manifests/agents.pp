class backup::agents {

  $agents = lookup('backup::agents', Hash, 'deep', { })
  create_resources('backup::agent', $agents)
}
