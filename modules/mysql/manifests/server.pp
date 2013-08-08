class mysql::server ($rootPassword) {

	include 'mysql::service'

	$query = shellquote("SET PASSWORD FOR `root`@`%` = PASSWORD('${rootPassword}')")
	package {'mysql-server':
		ensure => present,
		before => Service['mysql'],
	}
	~>

	exec {'set mysql root password':
		command => "mysql -u root -e ${query}",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		refreshonly => true,
	}

	monit::entry {'mysql':
		content => template('mysql/monit'),
		ensure => present,
	}
}
