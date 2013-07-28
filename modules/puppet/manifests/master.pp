class puppet::master ($certname, $hieraDataDir = '/etc/puppet/hiera/data') {

	include 'puppet::common'

	package {'puppetmaster':
		ensure => present,
		require => Helper::Script['install puppet apt sources'],
	}
	->

	file {'/etc/puppet/manifests/site.pp':
		content => template('puppet/site.pp'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
	}
	->

	file {'/etc/puppet/hiera.yaml':
		content => template('puppet/hiera.yaml'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
	}
	->

	file {'/etc/puppet/config/master':
		content => template('puppet/config/master'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
		require => File['/etc/puppet/config'],
		notify => Exec['/etc/puppet/puppet.conf'],
	}
	->

	service {'puppetmaster':
		require => File['/etc/puppet/config/main'],
		subscribe => Exec['/etc/puppet/puppet.conf'],
	}
}
