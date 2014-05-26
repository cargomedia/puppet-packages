class network::host::advertise (
  $interface = undef,
  $aliases = undef
) {

  $ipaddr = get_ipaddress($interface)
  $aliases_list = $aliases? {
    undef => [$::fqdn],
    default => [$aliases, $::fqdn]
  }
  @@network::host{"advertised.$::fqdn":
    ipaddr => $ipaddr,
    aliases => $aliases_list
  }
}
