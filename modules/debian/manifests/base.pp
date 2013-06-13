class debian::base {

	require 'php53::cli'

	file { '/etc/apt/sources.list':
		source => 'puppet:///modules/debian/sources.list',
		ensure => present,
	}

	$packages = split(template('debian/dpkg.list'), "\n")
	package { $packages: ensure => installed }

}
