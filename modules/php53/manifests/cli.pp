class php53::cli {

	package { 'php5-cli':
		ensure => installed
	}
	->

	file { '/etc/php5/cli/php.ini':
		source => 'puppet:///modules/php53/cli/php.ini',
		ensure => present
	}
}
