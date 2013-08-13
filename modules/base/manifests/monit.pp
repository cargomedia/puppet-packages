class base::monit ($alertOnLoad1 = 20, $alertOnLoad5 = 10) {

	require '::monit'

	monit::entry {'system':
		content => template('base/monit'),
	}
}
