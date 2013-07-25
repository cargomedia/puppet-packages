class puppet::common {

	helper::script {'install puppet apt sources':
		content => template('puppet/install-apt-sources.sh'),
		unless => "dpkg -l puppetlabs-release | grep '^ii '",
	}
	->

	package {'puppet-common':
		ensure => present,
	}
	->

	file {'/etc/puppet/puppet.conf':
		content => template('puppet/puppet.conf'),
		ensure => present,
		group => 0, owner => 0, mode => 644,
	}
}
