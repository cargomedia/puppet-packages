class mysql::client {

	package { 'mysql-client-5.1':
		ensure => present,
	}
}
