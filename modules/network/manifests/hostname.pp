class network::hostname(
  $fqdn
) {

  include 'network::host::purge'

  $hostname = regsubst($fqdn, '^([^.]*).*$', '\1')

  network::host {$fqdn:
    ipaddr => '127.0.0.1',
    aliases => $hostname ? {
      $fqdn => ['localhost'],
      default => [$hostname, 'localhost']
    },
    before => Class['network::host::purge'],
  }

  file {'/etc/mailname':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => "${fqdn}\n",
  }

  file {'/etc/hostname':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    content => "${hostname}\n",
    notify  => Exec['hostname.sh'],
  }

  exec {'hostname.sh':
    command     => '/etc/init.d/hostname.sh start',
    refreshonly => true,
  }
}
