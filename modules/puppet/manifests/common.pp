class puppet::common {

	helper::script {'install puppet apt sources':
		content => template('puppet/common/install-apt-sources.sh'),
		unless => "dpkg -l puppetlabs-release | grep '^ii '",
	}
}
