class puppet::master ($dnsAltNames = [], $hieraDataDir = '/etc/puppet/hiera/data') {

	include 'puppet::common'

	file {'/etc/puppet/conf.d/master':
		content => template('puppet/conf.d/master'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
		notify => Exec['/etc/puppet/puppet.conf'],
	}
	->

	file {'/etc/puppet/manifests':
		ensure => directory,
		group => '0', owner => '0', mode => '0755',
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

	package {'puppetmaster':
		ensure => present,
		require => [
			Helper::Script['install puppet apt sources'],
			Exec['/etc/puppet/puppet.conf'],
			File['/etc/puppet/conf.d/main']
		],
	}
	->

	service {'puppetmaster':
		subscribe => Exec['/etc/puppet/puppet.conf'],
	}
	->

	monit::entry {'puppetmaster':
		content => template('puppet/monit/master')
	}
}
