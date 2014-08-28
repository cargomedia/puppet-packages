class snmp (
  $views      = [],
  $disks      = [],
  $communityNetwork   = '127.0.0.0/24',
  $communityName      = 'public'
) {

  file {'/etc/snmp/snmpd.conf':
    ensure => file,
    content => template("${module_name}/snmpd.conf"),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['snmpd'],
  }

  file {'/etc/default/snmpd':
    ensure => file,
    content => template("${module_name}/default"),
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

  @monit::entry {'snmpd':
    content => template("${module_name}/monit"),
    require => Package['snmpd'],
  }
}
