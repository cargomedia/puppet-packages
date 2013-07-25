class puppet::agent ($server = 'puppet') {

	helper::script {'install puppet apt sources':
		content => template('puppet/install-apt-sources.sh'),
		unless => "dpkg -l puppetlabs-release | grep '^ii '",
	}
	->

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
