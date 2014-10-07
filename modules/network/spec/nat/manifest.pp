node default {

  class {'network::nat':
    ifname_public => 'eth0',
    ifname_private => 'eth1',
  }
}
