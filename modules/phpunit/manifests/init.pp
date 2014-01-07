class phpunit($version = '3.7.28') {

  require 'php5'

  $phar = '/usr/local/lib/phpunit.phar'
  $binary = '/usr/local/bin/phpunit'
  $config = '/etc/php5/conf.d/phpunit.ini'

  exec {"curl ${phar}":
    command => "curl -sL https://github.com/sebastianbergmann/phpunit/releases/download/${version}/phpunit.phar > ${phar}",
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    unless => "test -f ${phar} && ${binary} --version | grep -w '${version}'",
    require => [File[$binary], File[$config], Class['php5']],
  }

  file {$binary:
    ensure => file,
    source => 'puppet:///modules/phpunit/phpunit.sh',
    mode => '0755',
  }

  file {$config:
    ensure => file,
    source => 'puppet:///modules/phpunit/phpunit.ini',
  }
}
