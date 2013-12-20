class ssh::knownhosts {

  require 'ssh'

  $aliases = get_knownhosts($fqdn)

  @@ssh::knownhost {$clientcert:
    hostname => $fqdn,
    aliases => $aliases,
    key => $sshrsakey,
  }

  Ssh::Knownhost <<| |>>
}
