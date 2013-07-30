define puppet::git-modules ($cloneUrl) {

	include 'puppet::common'
	require 'git'

	$path = "/etc/puppet/repos/${name}"

	exec {"puppet repo ${name}":
		command => "git clone ${cloneUrl} ${path}",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		creates => $path,
		notify => Exec['/etc/puppet/conf.d/main-modulepath'],
	}

	$command = "cd '${path}' && git pull --quiet"
	cron {"cron ${command}":
		command => $command,
		user    => root,
	}
}
