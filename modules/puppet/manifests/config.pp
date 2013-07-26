class puppet::config {

	exec {'/etc/puppet/puppet.conf':
		command => "cat /etc/puppet/config/* > /etc/puppet/puppet.conf",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		refreshonly => true,
	}
}
