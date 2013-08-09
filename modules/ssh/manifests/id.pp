define ssh::id ($host, $user, $sshDir, $private, $public, $type = 'ssh-rsa') {

	require 'ssh'

	exec {"${sshDir} for ${host}":
		command => "mkdir -p ${sshDir}",
		creates => $sshDir,
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
	}

	file {"${sshDir}/${host}":
		ensure => present,
		content => $private,
		group => '0',
		owner => $user,
		mode => '0600',
		require => Exec["${sshDir} for ${host}"],
	}

	file {"${sshDir}/${host}.pub":
		ensure => present,
		content => template('ssh/public'),
		group => '0',
		owner => $user,
		mode => '0644',
	}

	exec {"mkdir ${sshDir}/config.d for ${host}":
		provider => shell,
		command => "mkdir -p ${sshDir}/config.d",
		creates => "${sshDir}/config.d",
		user => $user,
	}
	->

	file {"${sshDir}/config.d/${host}":
		ensure => present,
		content => template('ssh/config-host'),
		group => '0',
		owner => $user,
		mode => '0644',
		notify => Exec["${sshDir}/config by ${host}"],
	}

	exec {"${sshDir}/config by ${host}":
		command => "cat ${sshDir}/config.d/* > ${sshDir}/config",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		user => $user,
		refreshonly => true,
	}
}
