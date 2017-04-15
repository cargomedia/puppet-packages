node default {

  class {'apt::update':
    before => Class['cacti::agent::apache::apc'],
  }

  class {'cacti::agent::apache::apc': }

}