class socket-redis::service (
	$redisHost = undef,
	$socketPorts = [],
	$statusPort = undef,
	$sslKeyFile = undef,
	$sslCertFile = undef,
	$logDir = undef
) {
	require 'socket-redis'

	$args = [
		parameterize('redis-host', $redisHost),
		parameterize("socket-ports", join($socketPorts, ',')),
		parameterize("ssl-key", $sslKeyFile),
		parameterize("ssl-cert", $sslCertFile),
		parameterize("log-dir", $logDir)
	]

	file {'/etc/init.d/socket-redis':
		content => template('socket-redis/init.erb'),
	}
}
