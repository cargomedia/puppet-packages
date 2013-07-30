define apache2::mod ($enabled = true) {

	file {"/etc/apache2/mods-enabled/${mod}.load":
		ensure => $enabled ? {true => link, false => absent},
		target => "/etc/apache2/mods-available/${mod}.load",
		group => '0',
		owner => '0',
		mode => '0644',
	}
}
