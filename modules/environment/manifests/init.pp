class environment {

	file {'/etc/environment':
		ensure => present,
		group => '0',
		owner => '0',
		mode => '0644',
	}
}
