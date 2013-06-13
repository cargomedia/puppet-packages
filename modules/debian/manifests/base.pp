class debian::base {

	require 'php53::cli', 'monit', 'snmp', 'postfix'

	$ipPrivate = hiera('ipPrivate')
	$hostname = hiera('hostname')
	$domain = hiera('domain')
	$nameservers = hiera('nameservers')

	copy { '/etc/apt': module => 'debian' }
	copy { '/etc/cron-apt': module => 'debian' }
	copy { '/etc/security': module => 'debian' }
	copy { '/etc/ssh': module => 'debian' }
	copy { '/etc/sysctl.d': module => 'debian' }

	file { '/etc/hosts':
		content => template('debian/hosts.erb'),
		ensure => present,
	}

	file { '/etc/resolv.conf':
		content => template('debian/resolv.conf.erb'),
		ensure => present,
	}

	monit::entry { 'monit cron':
		name => 'cron',
		content => template('debian/monits/cron.erb'),
		ensure => present
	}

	monit::entry { 'monit postfix':
		name => 'postfix',
		content => template('debian/monits/postfix.erb'),
		ensure => present
	}

	monit::entry { 'monit system':
		name => 'system',
		content => template('debian/monits/system.erb'),
		ensure => present
	}

	$packages = split(template('debian/dpkg.list.erb'), "\n")
	package { $packages: ensure => installed }
}
