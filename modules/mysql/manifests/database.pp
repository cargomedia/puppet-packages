define mysql::database {

	require 'mysql::server'

	database {$name:
		ensure => present,
		provider => mysql,
		require => Service['mysql'],
	}

	if $user {
		database_grant {"${user}/${name}":
			provider => 'mysql',
			require => Mysql::User[$user],
		}
	}
}
