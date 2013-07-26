define ssh::config-host ($host = $name, $idFile) {

	include 'ssh'

	file {"/root/.ssh/config.d/${host}":
		ensure => present,
		content => template('ssh/config-host'),
		group => '0',
		owner => '0',
		mode => '0644',
		require => File['/root/.ssh/config.d'],
		notify => Exec['/root/.ssh/config'],
	}
}
