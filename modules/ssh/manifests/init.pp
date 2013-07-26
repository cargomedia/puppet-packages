class ssh {

	file {"/root/.ssh/config.d":
		ensure => directory,
		group => '0',
		owner => '0',
		mode => '0755',
	}

	exec {'/root/.ssh/config':
		command => 'cat /root/.ssh/config.d/* > /root/.ssh/config',
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		refreshonly => true,
	}
}
