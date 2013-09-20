class networking ($ipPrivate, $hosts = []) {

  if $hosts {
    @@host {$hosts[0]:
      ensure => present,
      host_aliases => $hosts,
      ip => $ipPrivate,
      tag => $domain,
    }
  }

  Host <<| tag == $domain |>>
}
