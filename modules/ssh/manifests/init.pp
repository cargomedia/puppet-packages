class ssh {

	file {"/etc/ssh/ssh_id":
		ensure => directory,
		group => '0',
		owner => '0',
		mode => '0755',
	}

	file {"/etc/ssh/ssh_config.d":
		ensure => directory,
		group => '0',
		owner => '0',
		mode => '0755',
	}

	exec {'/etc/ssh/ssh_config':
		command => 'cat /etc/ssh/ssh_config.d/* > /etc/ssh/ssh_config',
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		refreshonly => true,
	}
}
