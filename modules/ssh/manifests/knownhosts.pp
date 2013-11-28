class ssh::knownhosts {

  $hosts = get_knownhosts()

  @@ssh::knownhost {$hosts['host']:
    aliases => $hosts['aliases'],
    key => $sshrsakey,
  }

  Ssh::Knownhost <<| |>>
}
