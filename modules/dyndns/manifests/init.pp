class dyndns {

  require ['apt', 'cron']
  ensure_packages(['dnsutils'], { provider => 'apt' })

  $updaters = lookup('dyndns_updaters', Hash, 'deep', { })
  create_resources('dyndns::updater', $updaters)

}
