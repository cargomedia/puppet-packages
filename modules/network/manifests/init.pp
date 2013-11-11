class network() {

  $interfaces = hiera_hash('network::interfaces', {})
  create_resources('network::interface', $interfaces)

  $hosts = hiera_hash('network::hosts', {})
  create_resources('network::host', $hosts)

  network::host {$::fqdn:
    ipaddr => '127.0.0.1',
    aliases => [$::hostname, 'localhost']
  }

  network::host {$::hostname:
    ipaddr => '127.0.1.1',
    aliases => [$::fqdn]
  }

  resources {'host':
    purge => true
  }
}
