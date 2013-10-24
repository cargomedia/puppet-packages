node default {

  network::if::static {'eth0':
    ipaddress => '127.0.0.1',
    bonding_opt => {
      'mode' => 4,
      'miimon' => 100,
      'downdelay' => 0,
      'updelay' => 0,
      'lacp-rate' => 'fast',
      'xmit_hash_policy' => 1
    }
  }

  network::alias {'eth0:1'
    ipaddress => '127.0.0.1',
    netmask => '255.255.255.0',
  }

  network::host {'foo':
    ipaddress => '10.10.10.100',
    aliases => ['boo', 'moo']
  }

  network::dns {'dns':
    search => ['example.local', 'example.com'],
    nameserver => ['172.168.1.2', '8.8.8.8']
  }

  network::route {'10.0.0.0/8':
    gateway => '10.55.40.129',
    interface => 'bond0',
    routing_opts => {
      'irtt' => 24,
      'MTU' => 3000
    }
  }
}
