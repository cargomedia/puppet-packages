class mysql::server {

	package {'mysql-server':
		ensure => present,
	}

	monit::entry {'mysql':
		content => template('mysql/monit'),
		ensure => present,
	}
}
