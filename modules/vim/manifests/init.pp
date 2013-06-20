class vim {

	require debian::base

	file { "${homedir}/.vimrc":
		content => template('vim/.vimrc'),
		ensure => present,
	}
}
