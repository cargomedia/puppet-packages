class postfix {

	package { 'postfix':
		ensure => installed,
	}

	file { '/etc/postfix/main.cf':
		content => template('postfix/main.cf.erb'),
		ensure => present,
	}
}
