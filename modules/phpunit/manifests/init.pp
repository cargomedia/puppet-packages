class phpunit($version = '3.7.28') {

  require 'php5'

  $phar = '/usr/local/lib/phpunit.phar'
  $binary = '/usr/local/bin/phpunit'
  $config = '/etc/php5/conf.d/phpunit.ini'

  exec {"curl ${phar}":
    command => "curl -sL https://github.com/sebastianbergmann/phpunit/releases/download/${version}/phpunit.phar > ${phar}",
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless => "${binary} --version | grep -w '${version}'",
    require => [File[$binary], File[$config]],
  }

  file {$binary:
    ensure => file,
    content => template('phpunit/phpunit.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {$config:
    ensure => file,
    content => template('phpunit/phpunit.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
