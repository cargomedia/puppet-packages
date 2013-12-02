class ssh::knownhosts(
  $fqdn = $fqdn
) {

  require 'ssh'

  $aliases = get_knownhosts($fqdn)

  @@ssh::knownhost {$fqdn:
    aliases => $aliases,
    key => $sshrsakey,
  }

  Ssh::Knownhost <<| |>>
}
