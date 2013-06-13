class snmp::agent {

	package { 'snmpd':
		ensure => installed,
	}

	file { '/etc/snmp/snmpd.conf':
		ensure => present,
		content => template('snmp/conf.erb'),
	}

	monit::entry { 'monit snmpd':
		name => 'snmpd',
		content => template('snmp/monit.erb'),
		ensure => present
	}
}
