class mountpoint::nfs-check {

	$script = '/root/bin/check-nfs-mounts.sh'

	file { $script:
		source => 'puppet:///modules/mountpoint/check-nfs-mounts.sh',
		ensure => present
	}

	cron { "cron ${script}":
		command => $script,
		user    => root,
		ensure  => present
	}
}
