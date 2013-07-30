class openx (
	$host = $name,
	$certificatePem,
	$certificateKey,
	$certificateCa,
	$version = '2.8.10'
) {

	require 'php5::apache2'

	helper::script {'install openx':
		content => template('openx/install.sh'),
		unless => "test -e /var/openx/README.txt && grep -q 'Version ${version}$' /var/openx/README.txt",
	}

	file {'/var/openx/ssl':
		ensure => directory,
		group => '0',
		owner => '0',
		mode => '0755',
		require => Helper::Script['install openx'],
	}

	file {'/var/openx/ssl-ca':
		ensure => directory,
		group => '0',
		owner => '0',
		mode => '0755',
		require => Helper::Script['install openx'],
	}


	file {"/var/openx/ssl/${host}.pem":
		ensure => present,
		content => $certificatePem,
		group => '0',
		owner => '0',
		mode => '0644',
		before => Apache2::Vhost[$host],
	}

	file {"/var/openx/ssl/${host}.key":
		ensure => present,
		content => $certificateKey,
		group => '0',
		owner => '0',
		mode => '0644',
		before => Apache2::Vhost[$host],
	}

	if $certificateCa {
		file {"/var/openx/ssl-ca/${host}":
			ensure => present,
			content => $certificateCa,
			group => '0',
			owner => '0',
			mode => '0644',
		}
		~>

		exec {"/var/openx/ssl-ca/ for ${host}":
			provider => shell,
			command => "ln -s ${host} $(openssl x509 -noout -hash -in ${host}).0",
			cwd => '/var/openx/ssl-ca/',
			refreshonly => true,
			before => Apache2::Vhost[$host],
		}
	}

	apache2::vhost {$host:
		content => template('openx/vhost'),
	}
}
