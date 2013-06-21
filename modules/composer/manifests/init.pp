class composer($version = '1.0.0-alpha7') {

	$binary = '/usr/local/lib/composer.phar'

	exec {"curl ${binary}":
		command => "curl -sL http://getcomposer.org/download/${version}/composer.phar > ${binary}",
		path => ['/usr/local/bin', '/usr/bin', '/bin'],
		unless => "test -f ${binary} && ${binary} --version | grep -w '${version}'"
	}

	file {'/usr/local/bin/composer':
		source => 'puppet:///modules/composer/composer.sh',
		mode => 0755,
		ensure => present,
	}

	file {'/etc/php5/conf.d/composer.ini':
		source => 'puppet:///modules/composer/composer.ini',
		ensure => present,
	}
}
