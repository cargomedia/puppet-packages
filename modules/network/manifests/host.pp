define network::host (
  $ipaddr,
  $aliases  = [],
) {

  include 'network::host::purge'

  host {$name:
    ensure => present,
    host_aliases => $aliases,
    ip => $ipaddr,
    before => Class['network::host::purge'],
  }
}
