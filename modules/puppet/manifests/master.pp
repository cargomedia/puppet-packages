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

	file {'/etc/puppet/conf.d/master':
		content => template('puppet/conf.d/master'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
		require => File['/etc/puppet/conf.d'],
		notify => Exec['/etc/puppet/puppet.conf'],
	}
	->

	service {'puppetmaster':
		require => File['/etc/puppet/conf.d/main'],
		subscribe => Exec['/etc/puppet/puppet.conf'],
	}
}
