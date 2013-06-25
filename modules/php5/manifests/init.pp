class php5 {

	package { ['php', 'php5-cli']:
		ensure => installed
	}
	->

	file { '/etc/php5/cli/php.ini':
		source => 'puppet:///modules/php5/cli/php.ini',
		ensure => present
	}
}
