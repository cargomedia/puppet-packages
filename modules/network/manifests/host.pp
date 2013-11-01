define network::host (
  $ipaddr   = undef,
  $aliases  = [],
) {

  host {$name:
    ensure => present,
    host_aliases => $aliases,
    ip => $ipaddress,
  }
}
