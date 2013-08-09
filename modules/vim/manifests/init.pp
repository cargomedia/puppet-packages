class vim {

	file {'/etc/vim':
		ensure => directory,
		owner => '0',
		group => '0',
		mode => '755',
	}

	file {'/etc/vim/vimrc.local':
		ensure => file,
		content => template('vim/vimrc'),
		owner => '0',
		group => '0',
		mode => '644',
	}

	package {'vim':
		ensure => present,
	}
}
