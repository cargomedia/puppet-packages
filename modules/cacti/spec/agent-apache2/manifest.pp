node default {

  class {'apt::update':
    before => Class['cacti::agent::apache2'],
  }

  class {'cacti::agent::apache2':
    ipPrivateNetwork => '10.10.10.0/24'
  }
}