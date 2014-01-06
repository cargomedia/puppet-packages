class composer($version = '1.0.0-alpha7') {

  require 'php5'

  $phar = '/usr/local/lib/composer.phar'
  $binary = '/usr/local/bin/composer'

  exec {"curl ${phar}":
    command => "curl -sL http://getcomposer.org/download/${version}/composer.phar > ${phar}",
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    unless => "test -f ${phar} && ${binary} --version | grep -w '${version}'",
    require => [File[$binary], Php5::Extension::Config['suhosin'], Class['php5']],
  }

  file {$binary:
    ensure => file,
    source => 'puppet:///modules/composer/composer.sh',
    mode => '0755',
  }

  php5::extension::config {'suhosin':
    settings => {
      'suhosin.executor.include.whitelist' => 'phar'
    }
  }

}
