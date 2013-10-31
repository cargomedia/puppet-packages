node default {

  network::if::static {'static':
    device => 'eth1',
    ipaddr => '10.10.20.10',
    netmask => '255.255.0.0',
    gateway => '10.10.10.1',
    slaves => 'eth2 eth3',
    mtu => 9000,
    bonding_opts => {
      'mode' => 4,
      'miimon' => 100,
      'downdelay' => 0,
      'updelay' => 0,
      'lacp-rate' => 'fast',
      'xmit_hash_policy' => 1
    },
    route_opts => 'route add -net 10.0.0.0/8 gw 10.55.40.129',
    up => true,
  }

  network::if::dhcp {'dynamic':
    device => 'eth2',
    up => true,
  }

  network::host {'foo':
    ipaddr  => '10.10.10.100',
    aliases => ['boo', 'moo']
  }

  network::resolv {'resolvconf':
    search => ['example.local', 'example.com'],
    nameserver => ['172.168.1.2', '8.8.8.8'],
    domain     => "example.com",
  }
}
