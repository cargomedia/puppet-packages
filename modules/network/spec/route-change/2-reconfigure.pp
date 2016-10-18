node default {

  network::interface { 'eth1':
    method       => 'static',
    ipaddr       => '10.10.20.122',
    netmask      => '255.255.255.0',
    route_opts   => 'route add -net 10.10.134.0 netmask 255.255.255.128 gw 10.10.20.128; route add -net 10.10.138.0 netmask 255.255.255.192 gw 10.10.20.138',
  }
}
