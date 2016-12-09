node default {

  iptables::entry { 'Set up NAT for foo1':
    table => 'nat',
    chain => 'POSTROUTING',
    rule  => '-o foo1 -j MASQUERADE',
  }
  ->

  iptables::entry { 'Reject rule':
    chain => 'INPUT',
    rule  => '-i bar1 -j REJECT',
  }
}
