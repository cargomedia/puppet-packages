class dyndns {

  require ['apt', 'cron']
  ensure_packages(['dnsutils'], { provider => 'apt' })

  $updaters = hiera_hash('dyndns_updaters', { })
  create_resources('dyndns::updater', $updaters)

}
