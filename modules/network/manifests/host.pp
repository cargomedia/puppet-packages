define network::host (
  $ipaddress  = undef,
  $aliases    = [],
) {

  host {$name:
    ensure => present,
    host_aliases => $hosts,
    ip => $ipaddress,
    tag => $domain,
  }
}
