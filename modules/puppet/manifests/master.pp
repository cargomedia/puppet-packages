class puppet::master ($certname) {

	require 'puppet::common'

	package {'puppetmaster':
		ensure => present,
	}
	->

	file {'/etc/puppet/manifests/site.pp':
		content => template('puppet/site.pp'),
		ensure => present,
		group => 0, owner => 0, mode => 644,
	}
	->

	file {'/etc/puppet/hiera.yaml':
		content => template('puppet/hiera.yaml'),
		ensure => present,
		group => 0, owner => 0, mode => 644,
	}
}
