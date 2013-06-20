class debian::base {

	$packages = split(template('debian/dpkg.list'), "\n")
	package { $packages: ensure => installed }

}
