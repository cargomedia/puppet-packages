class mysql::server ($rootPassword = undef) {

	include 'mysql::service'

	file {'/root/.my.cnf':
		ensure => $rootPassword ? {
			undef => absent,
			default => file,
		},
		content => template('mysql/client-config.cnf'),
		owner => '0',
		group => '0',
		mode => '0600',
	}

	user {'mysql':
		ensure => present,
		system => true,
	}
	->

	file {'/etc/mysql':
		ensure => directory,
		owner => '0',
		group => '0',
		mode => '0755',
	}
	->

	file {'/etc/mysql/init.sql':
		ensure => file,
		content => template('mysql/init.sql'),
		owner => 'root',
		group => 'mysql',
		mode => '0640',
		notify => Service['mysql'],
	}
	->

	file {'/etc/mysql/my.cnf':
		ensure => file,
		content => template('mysql/my.cnf'),
		owner => 'root',
		group => 'mysql',
		mode => '0640',
	}

	->

	package {'mysql-server':
		ensure => present,
		before => Service['mysql'],
	}
	->

	monit::entry {'mysql':
		ensure => present,
		content => template('mysql/monit'),
	}
}
