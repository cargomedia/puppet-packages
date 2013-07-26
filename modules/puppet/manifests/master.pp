class puppet::master ($certname) {

	require 'puppet::common'

	file {'/etc/puppet/manifests/site.pp':
		content => template('puppet/site.pp'),
		ensure => present,
		group => 0, owner => 0, mode => 644,
	}

	file {'/etc/puppet/hiera.yaml':
		content => template('puppet/hiera.yaml'),
		ensure => present,
		group => 0, owner => 0, mode => 644,
	}

	package {'puppetmaster':
		ensure => present,
		require => [File['/etc/puppet/manifests/site.pp'], File['/etc/puppet/hiera.yaml']],
	}

	file {'/etc/puppet/config/master':
		content => template('puppet/config/master'),
		ensure => present,
		group => '0', owner => '0', mode => '0644',
		notify => Exec['/etc/puppet/puppet.conf'],
	}
}
