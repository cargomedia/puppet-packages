class base::monit ($alertOnLoad1 = 20, $alertOnLoad5 = 10, $additionalChecks = []) {

	require '::monit'

	monit::entry {'system':
		content => template('base/monit'),
	}
}
