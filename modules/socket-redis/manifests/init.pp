class socket-redis {

	require 'nodejs'

	package { 'socket-redis':
		ensure => '0.0.23',
		provider => 'npm',
	}
}
