class base::monit ($alertOnLoad1 = undef, $alertOnLoad5 = undef) {

	require '::monit'

	monit::entry {'system':
		content => template('base/monit'),
	}
}
