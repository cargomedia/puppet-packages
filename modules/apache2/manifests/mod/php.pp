class apache2::mod::php {

	require 'apache2', 'php5'

	package { 'libapache2-mod-php5':
		ensure => present,
	}

	file { '/etc/php5/apache2/php.ini':
		source => 'puppet:///modules/php5/apache2/php.ini',
		ensure => present,
	}
}
