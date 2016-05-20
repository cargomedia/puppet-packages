node default {

  dyndns_updater { 'spec':
    fqdn => 'zone.example.com',
    server => 'dyndns.example.com',
    key_name => 'alice',
    key_secret => 'secret',
  }
}
