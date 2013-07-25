class puppet::agent ($server = 'puppet') {

	require 'puppet::common'

	package {'puppet':
		ensure => present,
	}
	->

	file {'/etc/puppet/puppet.conf':
		content => template('puppet/agent/puppet.conf'),
		ensure => present,
		group => 0, owner => 0, mode => 644,
	}
	->

	file {'/etc/default/puppet':
		content => template('puppet/agent/default'),
		ensure => present,
		group => 0, owner => 0, mode => 644,
	}

}
