class network::host::advertise (
  $interface = undef,
  $aliases = undef
) {

  $ipaddr = get_ipaddress($interface)

  if $ipaddr {
    $aliases_list = $aliases? {
      undef => [$::clientcert],
      default => [$aliases, $::clientcert]
    }
    @@network::host{"advertised.$::clientcert":
      ipaddr => $ipaddr,
      aliases => $aliases_list
    }
  } else {
    warning("Unable to figure out an ip address for the hostname to be advertised")
  }
}
