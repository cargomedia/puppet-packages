define mysql::database {

	require 'mysql::server'

	database {$name:
		ensure => present,
		provider => 'mysql',
	}
}
