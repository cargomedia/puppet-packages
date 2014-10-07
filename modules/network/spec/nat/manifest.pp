node default {

  iptables::reset {'Reset iptables': }
  ->

  class {'network::nat':
    ifname_public => 'eth0',
    ifname_private => 'eth1',
  }
}
