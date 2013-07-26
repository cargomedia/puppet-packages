class ssh {

	file {"/root/.ssh/config.d":
		ensure => directory,
		group => '0',
		owner => '0',
		mode => '0755',
	}
}
