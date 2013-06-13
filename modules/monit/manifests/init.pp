class monit {

	package { 'monit':
		ensure => installed
	}

	copy { '/etc/default/monit': module => 'monit' }
}
