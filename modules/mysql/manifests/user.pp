define mysql::user($user = $name, $password) {

	require 'mysql::server'

	mysql::query{"CREATE USER `${user}` IDENTIFIED BY '${password}'":
	}

}
