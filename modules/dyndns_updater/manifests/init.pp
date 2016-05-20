define dyndns_updater(
  $fqdn = $title,
  $server = 'update.dyndns.com',
  $key_name,   # Keyname and Key secret have to be set up with a *paid* account at dyn.com
  $key_secret, #
  $ttl = 60,
  $ip_address = undef,
  $cron_interval_minutes = 10,
) {

  require ['apt', 'cron']

  ensure_packages(['dnsutils'], { provider => 'apt' })

  file {
    '/etc/dyndns_updater':
      ensure  => directory,
      owner   => '0',
      group   => '0',
      mode    => '0644';
    '/etc/dyndns_updater/script':
      ensure  => file,
      content => template("dyndns_updater/script.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
  }

  $external_ip_address = $::facts['external_ip']

  $ip_address_final = $ip_address ? {
    undef =>  $external_ip_address,
    default => $ip_address,
  }

  if ($ip_address_final == '') {
    fail('ERROR - Could not establish an IP address to use. Set it up manually, please.')
  }

  cron { "Update ${name} at dyndns":
    command => " 2>&1 /usr/bin/nsupdate /etc/dyndns_updater/script >/dev/null || echo 'An error occured updating Dyndns'",
    minute  => "*/${cron_interval_minutes}",
    require => File['/etc/dyndns_updater/script'],
  }
}
