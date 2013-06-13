class nodejs ($version = '0.10.4') {

	require debian::base

	package { ['python', 'libevent-1.4-2', 'libssl-dev']: ensure => present }
	->

	user {'nodejs':
		system => true,
		# gid => 'nodejs',
	}
	->

	script {'install.sh':
		content => template('nodejs/install.erb'),
	}
}
