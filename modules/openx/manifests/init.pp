class openx (
	$host,
	$certificatePem,
	$certificateKey,
	$certificateCa,
	$version = '2.8.11'
) {

	require 'php5::apache2'
	require 'php5::extension::mysql'
	require 'php5::extension::gd'
	require 'openssl'
	require 'apache2::mod::ssl'
	require 'mysql::server'

	helper::script {'install openx':
		content => template('openx/install.sh'),
		unless => "test -e /var/openx/README.txt && grep -q 'Version ${version}$' /var/openx/README.txt",
	}

	file {'/var/openx/ssl':
		ensure => directory,
		group => 'www-data',
		owner => 'www-data',
		mode => '0755',
		require => Helper::Script['install openx'],
	}

	file {'/var/openx/ssl-ca':
		ensure => directory,
		group => 'www-data',
		owner => 'www-data',
		mode => '0755',
		require => Helper::Script['install openx'],
	}

	file {"/var/openx/ssl/${host}.pem":
		ensure => present,
		content => $certificatePem,
		group => 'www-data',
		owner => 'www-data',
		mode => '0644',
		before => Apache2::Vhost[$host],
	}

	file {"/var/openx/ssl/${host}.key":
		ensure => present,
		content => $certificateKey,
		group => 'www-data',
		owner => 'www-data',
		mode => '0644',
		before => Apache2::Vhost[$host],
	}

	if $certificateCa {
		file {"/var/openx/ssl-ca/${host}":
			ensure => present,
			content => $certificateCa,
			group => 'www-data',
			owner => 'www-data',
			mode => '0644',
		}
		->

		exec {"/var/openx/ssl-ca/ for ${host}":
			provider => shell,
			command => "ln -s ${host} $(openssl x509 -noout -hash -in ${host}).0",
			unless => "test -L $(openssl x509 -noout -hash -in ${host}).0",
			cwd => '/var/openx/ssl-ca/',
			before => Apache2::Vhost[$host],
		}
	}

	file {'/var/openx/www/delivery/ajs-proxy.php':
		ensure => present,
		content => template('openx/ajs-proxy.php'),
		group => 'www-data',
		owner => 'www-data',
		mode => '0644',
		require => Helper::Script['install openx'],
	}

	mysql::user {'openx@localhost':
		password => $password,
	}

	mysql::database {'openx':
		user => 'openx@localhost',
	}

	apache2::vhost {$host:
		content => template('openx/vhost'),
	}
}
