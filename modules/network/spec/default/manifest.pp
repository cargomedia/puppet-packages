node default {

  network::interface {'eth0':
    method      => 'dhcp',
  }
  ->

  network::interface {'eth1':
    method       => 'static',
    ipaddr       => '10.10.20.122',
    netmask      => '255.255.255.0',
    slaves       => 'eth2 eth3',
    mtu          => 9000,
    bonding_opts => {
      'mode' => 4,
      'miimon' => 100,
      'downdelay' => 0,
      'updelay' => 0,
      'lacp-rate' => 'fast',
      'xmit_hash_policy' => 1
    },
    route_opts   => 'route add -net 10.10.130.0 netmask 255.255.255.0 gw 10.10.20.128',
  }
  ->

  network::interface {'eth3':
    method      => 'manual',
    ipaddr      => '10.10.40.10',
    netmask     => '255.255.255.0',
    gateway     => '10.10.40.1',
    mtu         => 16000,
  }
  ->

  network::host {'foo':
    ipaddr  => '10.10.10.100',
    aliases => ['boo', 'moo']
  }

  class {'network::resolv':
    search     => ['example.local', 'example.com'],
    nameserver => ['172.168.1.2', '8.8.8.8'],
    domain     => 'example.com',
  }
}
