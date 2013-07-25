class puppet::master ($certname) {

	require 'puppet::common'

	package {'puppetmaster':
		ensure => present,
	}

}
