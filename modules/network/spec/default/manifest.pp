node default {

  network::interface {'eth1':
    method  => 'static',
    ipaddr  => '10.10.20.10',
    netmask => '255.255.0.0',
    gateway => '10.10.10.1',
    slaves  => 'eth2 eth3',
    mtu     => 9000,
    bonding_opts => {
      'mode' => 4,
      'miimon' => 100,
      'downdelay' => 0,
      'updelay' => 0,
      'lacp-rate' => 'fast',
      'xmit_hash_policy' => 1
    },
    route_opts => 'route add -net 10.0.0.0/8 gw 10.55.40.129',
  }

  network::interface {'eth2':
    method      => 'dhcp',
    applyconfig => false
  }

  network::host {'foo':
    ipaddr  => '10.10.10.100',
    aliases => ['boo', 'moo']
  }

  class {'network::resolv':
    search => ['example.local', 'example.com'],
    nameserver => ['172.168.1.2', '8.8.8.8'],
    domain     => "example.com",
  }
}
