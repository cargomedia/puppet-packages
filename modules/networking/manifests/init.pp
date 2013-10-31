class networking ($ipaddress, $hosts = [], $interfaces = undef) {

  if $hosts {
    @@host {$hosts[0]:
      ensure => present,
      host_aliases => $hosts,
      ip => $ipaddress,
      tag => $domain,
    }
  }

  Host <<| tag == $domain |>>

  if $interfaces {
    file {'/etc/network/interfaces':
      ensure => file,
      content => $interfaces,
      owner => '0',
      group => '0',
      mode => '0644',
    }
  }
}
