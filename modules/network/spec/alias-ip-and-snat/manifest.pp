node default {

  require 'network'

  network::snat { 'Modify source ip for outgoing traffic on all interfaces':
    from_ip => '10.10.20.122',
    source_address => '192.168.20.122',
  }
}
