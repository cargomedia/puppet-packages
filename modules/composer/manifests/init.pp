class composer($version = '1.0.0-alpha7') {

	$phar = '/usr/local/lib/composer.phar'
	$binary = '/usr/local/bin/composer'
	$config = '/etc/php5/conf.d/composer.ini'

	exec {"curl ${phar}":
		command => "curl -sL http://getcomposer.org/download/${version}/composer.phar > ${phar}",
		path => ['/usr/local/bin', '/usr/bin', '/bin'],
		unless => "test -f ${phar} && ${binary} --version | grep -w '${version}'",
		require => [File[$binary], File[$config], Class['php5']],
	}

	file {$binary:
		source => 'puppet:///modules/composer/composer.sh',
		mode => 0755,
		ensure => present,
	}

	file {$config:
		source => 'puppet:///modules/composer/composer.ini',
		ensure => present,
	}
}
