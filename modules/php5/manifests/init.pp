class php5 {

	package { ['php5-common', 'php5-cli', 'php5-dev', 'libpcre3-dev']:
		ensure => present,
	}

	file { '/etc/php5/cli/php.ini':
		ensure => present,
		source => 'puppet:///modules/php5/cli/php.ini',
		owner => '0',
		group => '0',
		mode => '0644',
		require => Package['php5-cli'],
	}
}
