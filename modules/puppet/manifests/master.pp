class puppet::master ($dnsAltNames = [], $hieraDataDir = '/etc/puppet/hiera/data', $reportToEmail = 'root') {

	include 'puppet::common'

	file {'/etc/puppet/conf.d/master':
		ensure => file,
		content => template('puppet/conf.d/master'),
		group => '0',
		owner => '0',
		mode => '0644',
		notify => Exec['/etc/puppet/puppet.conf'],
		before => Package['puppetmaster'],
	}

	file {'/etc/puppet/manifests':
		ensure => directory,
		group => '0',
		owner => '0',
		mode => '0755',
	}

	file {'/etc/puppet/manifests/site.pp':
		ensure => file,
		content => template('puppet/site.pp'),
		group => '0',
		owner => '0',
		mode => '0644',
		before => Package['puppetmaster'],
		notify => Service['puppetmaster'],
	}

	file {'/etc/puppet/hiera.yaml':
		ensure => file,
		content => template('puppet/hiera.yaml'),
		group => '0',
		owner => '0',
		mode => '0644',
		before => Package['puppetmaster'],
		notify => Service['puppetmaster'],
	}

	if $reportToEmail {
		file {'/etc/puppet/tagmail.conf':
			ensure => file,
			content => template('puppet/tagmail.conf'),
			group => '0',
			owner => '0',
			mode => '0644',
			before => Package['puppetmaster'],
			notify => Service['puppetmaster'],
		}
	}

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
