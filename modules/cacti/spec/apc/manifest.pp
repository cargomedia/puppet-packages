node default {

  class {'apt::update':
    before => Class['cacti::extension::apache2::apc'],
  }

  require 'cacti::extension::apache2::apc'

}