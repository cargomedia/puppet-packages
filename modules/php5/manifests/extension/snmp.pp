class php5::extension::snmp {

  require 'apt'
  require 'php5'

  package { 'php5-snmp':
    ensure   => present,
    provider => 'apt',
    require  => Class['php5'],
  }
}
