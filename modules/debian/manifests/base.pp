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

	copy { '/etc/hosts': module => 'debian', template => true }
	copy { '/etc/idmapd.conf': module => 'debian', template => true }
	copy { '/etc/resolv.conf': module => 'debian', template => true }

	monit::entry { 'monit cron':
		name => 'cron',
		content => template('debian/etc/monit/cron.erb'),
		ensure => present
	}

	monit::entry { 'monit postfix':
		name => 'postfix',
		content => template('debian/etc/monit/postfix.erb'),
		ensure => present
	}

	monit::entry { 'monit system':
		name => 'system',
		content => template('debian/etc/monit/system.erb'),
		ensure => present
	}

	$packages = split(template('debian/dpkg.list.erb'), "\n")
	package { $packages: ensure => installed }
}
