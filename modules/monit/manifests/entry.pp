define monit::entry ($content) {

	include 'monit'

	file { "/etc/monit/conf.d/${name}":
		content => $content,
		ensure => file,
		group => 0, owner => 0, mode => 644,
		require => Package['monit'],
		notify => Service['monit'],
	}
}
