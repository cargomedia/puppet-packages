class php5::apache2 {

	require '::apache2'

	package { ['php5', 'libapache2-mod-php5']:
		ensure => present,
	}

	file { '/etc/php5/apache2/php.ini':
		source => 'puppet:///modules/php5/apache2/php.ini',
		ensure => present,
		owner => 0, group => 0, mode => 0644,
		require => Package['php5', 'libapache2-mod-php5'],
	}
}
