define mysql::query ($query = $name, $unless = undef) {

	require 'mysql::server'

	$rootPassword = hiera('mysql::server::rootPassword')
	$escapedQuery = shellquote($query)
	if ($unless) {
		$escapedUnlessQuery = shellquote($unless)
	}

	exec {$query:
		provider => shell,
		command => "mysql -u root -p${rootPassword} -e ${escapedQuery}",
		path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
		unless => $unless ? {
			undef => undef,
			default => "RESPONSE=$(mysql -u root -pbar -e ${$escapedUnlessQuery}) && [ \"\$RESPONSE\" != \"\" ] ",
		}
	}
}
