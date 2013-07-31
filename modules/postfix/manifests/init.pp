class postfix {

	file {'/etc/postfix':
		ensure => directory,
		group => '0',
		owner => '0',
		mode => '0644',
	}

	file {'/etc/postfix/main.cf':
		ensure => present,
		content => template('postfix/main.cf'),
		group => '0',
		owner => '0',
		mode => '0644',
		notify => Service['postfix'],
		before => Package['postfix'],
	}


	file {'/etc/postfix/virtual':
		ensure => present,
		content => template('postfix/virtual'),
		group => '0',
		owner => '0',
		mode => '0644',
		notify => Service['postfix'],
		before => Package['postfix'],
	}
	~>

	exec {'postmap /etc/postfix/virtual':
		command => 'postmap /etc/postfix/virtual',
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		refreshonly => true,
		require => Package['postfix'],
	}

	package {'postfix':
		ensure => installed,
	}
}
