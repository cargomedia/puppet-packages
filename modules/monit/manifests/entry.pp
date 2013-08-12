define monit::entry ($content, $ensure = present) {

	include 'monit'

	file { "/etc/monit/conf.d/${name}":
		content => $content,
		ensure => $ensure? { present => file, default => $ensure},
		group => 0, owner => 0, mode => 644,
		require => Package['monit'],
		notify => Service['monit'],
	}
}
