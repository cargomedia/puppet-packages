class network::nat (
  $ifname_public,
  $ifname_private,
  $to_source = undef,
) {

  $iptables_target = $to_source ? {
    undef => '-j MASQUERADE',
    default => "-j SNAT --to-source ${to_source}",
  }

  sysctl::entry { 'ip4_forward':
    entries => {
      'net.ipv4.ip_forward' => '1',
    }
  }

  iptables::entry { 'Set up NAT':
    table => 'nat',
    chain => 'POSTROUTING',
    rule  => "-o ${ifname_public} ${iptables_target}",
  }
  ->

  iptables::entry { 'Allow inbound traffic for established connection':
    chain => 'FORWARD',
    rule  => "-i ${ifname_public} -o ${ifname_private} -m state --state RELATED,ESTABLISHED -j ACCEPT",
  }
  ->

  iptables::entry { 'Allow outbound traffic':
    chain => 'FORWARD',
    rule  => "-i ${ifname_private} -o ${ifname_public} -j ACCEPT",
  }
}
