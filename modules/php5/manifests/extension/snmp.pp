class php5::extension::snmp {

  require 'php5'

  package {'php5-snmp':
    ensure => present,
    require => Class['php5'],
  }
}
