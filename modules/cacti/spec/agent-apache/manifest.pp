node default {

  class {'apt::update':
    before => Class['cacti::agent::apache::apc'],
  }

  class {'cacti::agent::apache::apc':
    network_addr => '10.10.10.0/24'
  }

}