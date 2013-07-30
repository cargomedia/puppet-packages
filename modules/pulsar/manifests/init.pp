class pulsar {

	require 'capistrano'
	require 'git'

	ruby::gem {'pulsar':
		ensure => present,
	}
}
