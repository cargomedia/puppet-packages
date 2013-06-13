class debian::base {

	require 'php53::cli'

	$packages = split(template('debian/dpkg.list'), "\n")
	package { $packages: ensure => installed }

}
