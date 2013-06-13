define monit::entry ($name, $content, $ensure) {

	require 'monit'

	file { "/etc/monit/conf.d/${name}":
		content => $content,
		ensure => $ensure,
	}
}
