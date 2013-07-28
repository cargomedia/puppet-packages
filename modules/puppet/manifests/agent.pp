class puppet::agent ($server = 'puppet') {

	include 'puppet::common'

	file {'/etc/default/puppet':
		content => template('puppet/default'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
	}
	->

	package {'puppet':
		ensure => present,
		require => Helper::Script['install puppet apt sources'],
	}
	->

	file {'/etc/puppet/conf.d/agent':
		content => template('puppet/conf.d/agent'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
		require => File['/etc/puppet/conf.d'],
		notify => Exec['/etc/puppet/puppet.conf'],
	}
	->

	service {'puppet':
		require => File['/etc/puppet/conf.d/main'],
		subscribe => Exec['/etc/puppet/puppet.conf'],
	}
}
