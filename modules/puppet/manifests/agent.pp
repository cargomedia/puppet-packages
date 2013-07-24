class puppet::agent {

	helper::script {'install puppet apt sources':
		content => template('puppet/install-apt-sources.sh'),
		unless => "dpkg -l puppetlabs-release | grep '^ii '",
	}

	package {'puppet':
		ensure => present,
	}

}
