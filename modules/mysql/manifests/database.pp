define mysql::database ($database = $name) {

	require 'mysql::server'

	mysql::query {"create database `${database}`":
		unless => "show databases like '${database}'",
	}

}
