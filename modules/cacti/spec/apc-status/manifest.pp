node default {

  class {'apt::update':
    before => Class['cacti::extension::apache2::apc-status'],
  }

  require 'cacti::extension::apache2::apc-status'

}