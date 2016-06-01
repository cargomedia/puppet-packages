define network::host (
  $ipaddr,
  $aliases  = [],
) {

  host { $name:
    ensure       => present,
    host_aliases => $aliases,
    ip           => $ipaddr,
  }

}
