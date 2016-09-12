node default {

  class { 'network::nat':
    ifname_public  => 'eth0',
    ifname_private => 'eth1',
    to_source => '10.73.8.2'
  }
}
