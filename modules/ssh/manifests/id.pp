define ssh::id ($private, $public, $hosts = []) {

	include 'ssh'

	file {"/etc/ssh/ssh_id/${name}":
		ensure => present,
		content => $private,
		group => '0',
		owner => '0',
		mode => '0600',
	}

	file {"/etc/ssh/ssh_id/${name}.pub":
		ensure => present,
		content => $public,
		group => '0',
		owner => '0',
		mode => '0644',
	}

	ssh::config-host {$hosts:
		idFile => "/etc/ssh/ssh_id/${name}",
	}
}
