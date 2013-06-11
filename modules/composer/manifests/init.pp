class composer($version = '1.0.0-alpha7') {

	package { 'curl': ensure => present }
	package { 'php5-cli': ensure => present }

	exec {'download':
		command => "curl -sL http://getcomposer.org/download/${version}/composer.phar > /usr/local/lib/composer.phar",
		creates => '/usr/local/lib/composer.phar',
		path => ['/usr/local/bin', '/usr/bin', '/bin'],
		require => Package['curl'],
	}

	file {'composer':
		source => 'puppet:///modules/composer/composer.sh',
		path => '/usr/local/bin/composer',
		mode => 0755,
		ensure => present,
		require => Exec['download']
	}
}
