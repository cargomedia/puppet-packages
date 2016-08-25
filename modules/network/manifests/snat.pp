define network::snat(
  $interface = undef,
  $from_ip = undef,
  $to_ip = undef,
  $source_address = undef,
) {

  $iface = $interface ? {
    undef => '',
    default => "-o ${interface}",
  }

  $src = $from_ip ? {
    undef => '',
    default => "-s ${from_ip}",
  }

  $dest = $to_ip ? {
    undef => '',
    default => "-s ${to_ip}",
  }

  iptables::entry { 'Set up SNAT':
    table => 'nat',
    chain => 'POSTROUTING',
    rule  => "${iface} ${src} ${dest} -j SNAT --to-source ${source_address}",
  }
}
