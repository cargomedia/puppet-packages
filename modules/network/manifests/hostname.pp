class network::hostname(
  $fqdn
) {

  include 'network::host::purge'

  $hostname = regsubst($fqdn, '^([^.]*).*$', '\1')
  $aliases = $hostname ? {
    $fqdn => ['localhost'],
    default => [$hostname, 'localhost']
  }

  network::host { $fqdn:
    ipaddr  => '127.0.0.1',
    aliases => $aliases,
    before  => Class['network::host::purge'],
  }

  file { '/etc/mailname':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${fqdn}\n",
  }

  file { '/etc/hostname':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${hostname}\n",
    notify  => Exec['apply hostname'],
  }

  exec { 'apply hostname':
    command     => "/bin/hostname ${hostname}",
    refreshonly => true,
  }
}
