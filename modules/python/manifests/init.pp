class python {

	package { 'python':
		ensure => installed
	}

	file { '/etc/python2.6/sitecustomize.py':
		source => 'puppet:///modules/python/sitecustomize.py',
		ensure => present,
	}

}
