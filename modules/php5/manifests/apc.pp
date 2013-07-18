class php5::apc ($version = '3.1.13') {

	require 'php5'

	file { '/etc/php5/conf.d/apc.ini':
		source => 'puppet:///modules/php5/conf.d/apc.ini',
		ensure => present,
	}

	helper::script {'install php5::apc':
		content => template('php5/apc-install.sh'),
		unless => "php --re apc | grep 'apc version' | grep ' ${version} '",
	}
}
