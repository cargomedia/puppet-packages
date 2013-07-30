define apache2::mod ($enabled = true) {

	include 'apache2::service'

	file {"/etc/apache2/mods-enabled/${name}.load":
		ensure => $enabled ? {true => link, false => absent},
		target => "/etc/apache2/mods-available/${name}.load",
		group => '0',
		owner => '0',
		mode => '0644',
		notify => Service['apache2'],
	}
}
