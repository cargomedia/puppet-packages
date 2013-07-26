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

	file {'/etc/puppet/config':
		ensure => directory,
		group => '0', owner => '0', mode => '0755',
	}

	file {'/etc/puppet/config/main':
		content => template('puppet/config/main'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
	}

	exec {'/etc/puppet/puppet.conf':
		command => "cat /etc/puppet/config/* > /etc/puppet/puppet.conf",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
	}
}
