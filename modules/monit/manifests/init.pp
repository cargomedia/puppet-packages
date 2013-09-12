class monit ($emailTo = 'root@localhost', $emailFrom = 'root@localhost', $allowedHosts = []) {

	include 'postfix'
	include 'monit::service'

	file { '/etc/default/monit':
		content => template('monit/default'),
		ensure => file,
		group => '0', owner => '0', mode => '0644',
		before => Package['monit'],
		notify => Service['monit'],
	}

	file { '/etc/monit':
		ensure => directory,
		group => '0', owner => '0', mode => '0755',
	}

	file { '/etc/monit/monitrc':
		content => template('monit/monitrc'),
		ensure => file,
		group => '0', owner => '0', mode => '0600',
		notify => Service['monit'],
		before => Package['monit'],
	}

	file { '/etc/monit/conf.d':
		ensure => directory,
		group => '0', owner => '0', mode => '0755',
		before => Package['monit'],
	}

	package {'monit':
		ensure => present,
		require => Package['postfix'],
	}
}
