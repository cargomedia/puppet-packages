class base ($alertOnLoad1 = 20, $alertOnLoad5 = 10) {

	require 'bash'
	require 'ssh'
	require 'postfix'
	require 'vim'
	require 'monit'

	monit::entry {'system':
		content => template('base/monit'),
	}
}
