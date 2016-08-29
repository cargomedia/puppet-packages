define network::snat(
  $interface = undef,
  $source_address,
) {

  $iface = $interface ? {
    undef => '',
    default => "-o ${interface}",
  }

  iptables::entry { $title:
    table => 'nat',
    chain => 'POSTROUTING',
    rule  => "${iface} -j SNAT --to-source ${source_address}",
  }
}
