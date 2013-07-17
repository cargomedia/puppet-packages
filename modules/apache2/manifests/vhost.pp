define apache2::vhost ($name, $content, $ensure) {

	require 'apache2'

	file { "/etc/apache2/sites-available/${name}":
		content => $content,
		ensure => $ensure,
	}
}
