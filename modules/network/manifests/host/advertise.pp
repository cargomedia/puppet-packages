class network::host::advertise (
  $interface = undef,
  $aliases = undef
) {

  $ipaddr = get_ipaddress($interface)

  if $ipaddr {
    $aliases_list = $aliases? {
      undef => [$::facts['fqdn']],
      default => concat($aliases, [$::facts['fqdn']])
    }
    @@network::host{ "advertised.${::facts['clientcert']}":
      ipaddr  => $ipaddr,
      aliases => $aliases_list
    }
  } else {
    fail('Unable to figure out an ip address for the hostname to be advertised')
  }
}
