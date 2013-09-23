class networking ($ipaddress, $hosts = []) {

  if $hosts {
    @@host {$hosts[0]:
      ensure => present,
      host_aliases => $hosts,
      ip => $ipaddress,
      tag => $domain,
    }
  }

  Host <<| tag == $domain |>>
}
