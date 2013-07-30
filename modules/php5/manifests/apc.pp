class php5::apc (
	$version = '3.1.13',
	$configureParams = '--enable-apc-mmap --enable-apc-pthreadmutex --disable-apc-debug --disable-apc-filehits --disable-apc-spinlocks'
) {

	require 'php5'

	helper::script {'install php5::apc':
		content => template('php5/apc-install.sh'),
		unless => "php --re apc | grep 'apc version' | grep ' ${version} '",
	}
	->

	file { '/etc/php5/conf.d/apc.ini':
		ensure => present,
		source => 'puppet:///modules/php5/conf.d/apc.ini',
		owner => '0',
		group => '0',
		mode => '0644',
	}
}
