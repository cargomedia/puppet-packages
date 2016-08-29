define network::snat(
  $interface = undef,
  $source_address,
) {

  $iface = $interface ? {
    undef => '',
    default => "-o ${interface}",
  }

  iptables::entry { 'Set up SNAT':
    table => 'nat',
    chain => 'POSTROUTING',
    rule  => "${iface} -j SNAT --to-source ${source_address}",
  }
}
