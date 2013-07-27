class puppet::config {

	exec {'/etc/puppet/puppet.conf':
		command => "cat /etc/puppet/config/* > /etc/puppet/puppet.conf",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		refreshonly => true,
	}

	exec {'/etc/puppet/config/main-modulepath':
		command => 'MODULEPATH=$(ls -d -1 /etc/puppet/repos/* | perl -pe \'s/(.*)\n/:$1\/modules/\'); echo "modulepath = /etc/puppet/modules:/usr/share/puppet/modules$MODULEPATH" > /etc/puppet/config/main-modulepath',
		provider => 'shell',
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		refreshonly => true,
		notify => Exec['/etc/puppet/puppet.conf'],
	}
}
