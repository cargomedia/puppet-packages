class php5::extension::snmp {

  require 'apt'
  require 'php5'

  package { 'php5-snmp':
    provider => 'apt',
    ensure  => present,
    require => Class['php5'],
  }
}
