class composer($version = '1.0.0-alpha7') {

	require debian::base

	exec {'curl /usr/local/lib/composer.phar':
		command => "curl -sL http://getcomposer.org/download/${version}/composer.phar > /usr/local/lib/composer.phar",
		creates => '/usr/local/lib/composer.phar',
		path => ['/usr/local/bin', '/usr/bin', '/bin'],
		require => Package['curl'],
	}

	file {'/usr/local/bin/composer':
		source => 'puppet:///modules/composer/composer.sh',
		mode => 0755,
		ensure => present,
		require => [Exec['download'], Package['php5-cli']]
	}
}
