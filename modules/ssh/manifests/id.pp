define ssh::id ($private, $public, $hosts = []) {

	include 'ssh'

	file {"/root/.ssh/${name}":
		ensure => present,
		content => $private,
		group => '0',
		owner => '0',
		mode => '0644',
	}

	file {"/root/.ssh/${name}.pub":
		ensure => present,
		content => $public,
		group => '0',
		owner => '0',
		mode => '0644',
	}

	ssh::config-host {$hosts:
		idFile => "/root/.ssh/${name}",
	}
}
