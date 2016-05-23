class dyndns {

  $updaters = hiera_hash('dyndns_updaters', { })
  create_resources('dyndns::updater', $updaters)

}
