class snmp (
  $views      = [],
  $disks      = [],
  $iphost     = '127.0.0.1',
  $ipnetwork  = '127.0.0.0/24',
  $community  = 'public'
) {

  file {'/etc/snmp/snmpd.conf':
    ensure => file,
    content => template('snmp/snmpd.conf'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['snmpd'],
  }

  file {'/etc/default/snmpd':
    ensure => file,
    content => template('snmp/default'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['snmpd'],
  }

  package {'snmp':
    ensure => present,
  }
  ->

  package {'snmpd':
    ensure => present,
  }
  ->

  monit::entry {'snmpd':
    content => template('snmp/monit')
  }
}
