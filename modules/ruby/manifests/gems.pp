class ruby::gems ($version = '1.6.2') {

	require 'ruby'

	helper::script {'install gems':
		content => template('ruby/install-gems.sh'),
		unless => 'which gem && gem --version | grep -P \'^\Q${version}\E$\'',
	}
}
