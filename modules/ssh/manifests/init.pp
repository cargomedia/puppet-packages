class ssh {

	package {'ssh':
		ensure => installed,
	}

	file {'/etc/ssh/ssh_config':
		ensure => present,
		content => template('ssh/ssh_config'),
		owner => '0',
		group => '0',
		mode => '0644',
	}

	file {'/etc/ssh/sshd_config':
		ensure => present,
		content => template('ssh/ssh_config'),
		owner => '0',
		group => '0',
		mode => '0644',
	}
}
