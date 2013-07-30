class apache2 {

	file {'/etc/apache2':
		ensure => directory,
		owner => '0',
		group => '0',
		mode => '0755',
	}
	->

	file {'/etc/apache2/apache2.conf':
		source => 'puppet:///modules/apache2/apache2.conf',
		ensure => present,
		owner => '0',
		group => '0',
		mode => '0644',
	}
	->

	package {'apache2':
		ensure => present,
	}
	->

	service {'apache2':}
}
