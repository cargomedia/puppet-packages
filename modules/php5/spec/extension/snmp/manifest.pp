node default {

  class {'apt' :
    before => Class['php5'],
  }

  require 'php5::extension::snmp'
}
