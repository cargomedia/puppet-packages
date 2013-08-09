define mysql::database ($user = undef) {

	require 'mysql::server'

	database {$name:
		ensure => present,
		provider => mysql,
	}

	if $user {
		database_grant {"${user}/${name}":
			provider => 'mysql',
			require => Mysql::User[$user],
		}
	}
}
