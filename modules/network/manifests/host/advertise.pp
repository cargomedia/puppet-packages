class network::host::advertise (
  $interface = undef,
  $aliases = undef
) {

  $ipaddr = get_ipaddress($interface)

  if $ipaddr {
    $name_to_export = $::certname? {
      undef => $::fqdn,
      default => $::certname
    }
    $aliases_list = $aliases? {
      undef => [$name_to_export],
      default => [$aliases, $name_to_export]
    }
    @@network::host{"advertised.$name_to_export":
      ipaddr => $ipaddr,
      aliases => $aliases_list
    }
  } else {
    warning("Unable to figure out an ip address for the hostname to be advertised")
  }
}
