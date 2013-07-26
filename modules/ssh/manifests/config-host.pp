define ssh::config-host ($host = $name, $idFile) {

	require 'ssh'

	file {"/root/.ssh/config.d/${host}":
		ensure => present,
		content => template('ssh/config-host'),
		group => '0',
		owner => '0',
		mode => '0644',
	}
}
