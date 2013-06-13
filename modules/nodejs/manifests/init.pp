class nodejs ($version = '0.10.4') {

	require debian::base

	package { ['python', 'libevent-1.4-2', 'libssl-dev']: ensure => present }

	user {'nodejs':
		ensure => present,
		system => true,
	}

	script {'install nodejs':
		content => template('nodejs/install.erb'),
	}
}
