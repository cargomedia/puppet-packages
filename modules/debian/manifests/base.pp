class debian::base {

	require 'php53::cli'

	file { '/etc/apt/':
		source => 'puppet:///modules/debian/etc/apt',
		recurse => true,
		ensure => present,
	}

	file { '/etc/cron-apt':
		source => 'puppet:///modules/debian/etc/cron-apt',
		recurse => true,
		ensure => present,
	}

	$packages = split(template('debian/dpkg.list'), "\n")
	package { $packages: ensure => installed }

}
