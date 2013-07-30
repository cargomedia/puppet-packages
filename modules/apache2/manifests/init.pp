class apache2 {

	package { 'apache2':
		ensure => present,
	}

	file { '/etc/apache2/apache2.conf':
		source => 'puppet:///modules/apache2/apache2.conf',
		ensure => present,
		group => '0',
		owner => '0',
		mode => '0644',
	}
}
