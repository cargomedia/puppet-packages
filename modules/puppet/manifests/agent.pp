class puppet::agent ($server = 'puppet') {

	require 'puppet::common'

	package {'puppet':
		ensure => present,
	}
	->

	file {'/etc/default/puppet':
		content => template('puppet/default'),
		ensure => present,
		group => 0, owner => 0, mode => 644,
	}

	file {'/etc/puppet/config/agent':
		content => template('puppet/config/agent'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
		notify => Exec['/etc/puppet/puppet.conf'],
	}
}
