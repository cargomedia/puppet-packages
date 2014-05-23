class network::host::advertise (
  $interface = undef,
  $aliases = undef
) {

  if $interface {
    $ipaddr = get_ipaddress($interface)
  } else {
    $ipaddr = get_ipaddress()
  }
  $aliases_list = $aliases? {
    undef => [$::fqdn],
    default => [$aliases, $::fqdn]
  }

  if $ipaddr {
    @@network::host{"advertised.$::fqdn":
      ipaddr => $ipaddr,
      aliases => $aliases_list
    }
  } else {
    warning("Class $title included for $::fqdn, but no ip address was found")
  }
}
