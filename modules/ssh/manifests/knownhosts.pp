class ssh::knownhosts {

  require 'ssh'

  $aliases = get_knownhosts($::facts['fqdn'])

  @@ssh::knownhost { $::facts['clientcert']:
    hostname => $::facts['fqdn'],
    aliases  => $aliases,
    key      => $::facts['sshrsakey'],
  }

  Ssh::Knownhost <<| |>>
}
