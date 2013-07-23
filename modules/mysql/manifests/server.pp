class mysql::server {

	package { 'mysql-server':
		ensure => present,
	}
}
