class puppet::common {

	helper::script {'install puppet apt sources':
		content => template('puppet/install-apt-sources.sh'),
		unless => "dpkg -l puppetlabs-release | grep '^ii '",
	}

	file {'/etc/puppet/config':
		ensure => directory,
		group => '0', owner => '0', mode => '0755',
	}

	file {'/etc/puppet/config/main':
		content => template('puppet/config/main'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
		require => File['/etc/puppet/config'],
		notify => Exec['/etc/puppet/config/main-modulepath'],
	}

	exec {'/etc/puppet/config/main-modulepath':
		command => 'MODULEPATH=$(ls -d -1 /etc/puppet/repos/* | perl -pe \'s/(.*)\n/:$1\/modules/\'); echo "modulepath = /etc/puppet/modules:/usr/share/puppet/modules$MODULEPATH" > /etc/puppet/config/main-modulepath',
		provider => 'shell',
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		refreshonly => true,
		require => File['/etc/puppet/config'],
		notify => Exec['/etc/puppet/puppet.conf'],
	}

	exec {'/etc/puppet/puppet.conf':
		command => "cat /etc/puppet/config/* > /etc/puppet/puppet.conf",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		refreshonly => true,
	}
}
