class network::nat (
  $ifname_public,
  $ifname_private
) {

  package {'iptables':
    ensure => present,
  }

  sysctl::entry {'ip4_forward':
    entries => {
      'net.ipv4.ip_forward' => '1',
    }
  }

  network::iptables {'Set up NAT':
    table => 'nat',
    chain => 'POSTROUTING',
    rule  => "-o ${ifname_public} -j MASQUERADE",
  }
  ->

  network::iptables {'Allow inbound traffic for established connection':
    chain => 'FORWARD',
    rule  => "-i ${ifname_public} -o ${ifname_private} -m state --state RELATED,ESTABLISHED -j ACCEPT",
  }
  ->

  network::iptables {'Allow outbound traffic':
    chain => 'FORWARD',
    rule  => "-i ${ifname_private} -o ${ifname_public} -j ACCEPT",
  }
}
