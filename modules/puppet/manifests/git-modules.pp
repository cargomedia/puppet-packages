define puppet::git-modules ($cloneUrl) {

	require 'puppet::common'

	$path = "/etc/puppet/repos/${name}"

	exec {"puppet repo ${name}":
		command => "git clone ${cloneUrl} ${path}",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		creates => $path,
		notify => Exec['/etc/puppet/config/main-modulepath'],
	}
}
