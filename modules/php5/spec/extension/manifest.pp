node default {

  require 'apt::update'
  require 'php5::extension::snmp'
}
