define ssh::config-host ($host = $name, $idFile) {

	include 'ssh'

	file {"/etc/ssh/ssh_config.d/${host}":
		ensure => present,
		content => template('ssh/config-host'),
		group => '0',
		owner => '0',
		mode => '0644',
		require => File['/etc/ssh/ssh_config.d'],
		notify => Exec['/etc/ssh/ssh_config'],
	}
}
