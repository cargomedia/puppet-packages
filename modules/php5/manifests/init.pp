class php5 {

	package { ['php5', 'php5-cli', 'php5-dev', 'libpcre3-dev']:
		ensure => present,
	}

	file { '/etc/php5/cli/php.ini':
		source => 'puppet:///modules/php5/cli/php.ini',
		ensure => present,
		require => Package['php5-cli'],
	}
}
