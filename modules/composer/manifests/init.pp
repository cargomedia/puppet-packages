class composer($version = '1.0.0-alpha9') {

  require 'php5'

  $phar = '/usr/local/lib/composer.phar'
  $binary = '/usr/local/bin/composer'
  $config = '/etc/php5/conf.d/composer.ini'

  exec {"curl ${phar}":
    command => "curl -sL http://getcomposer.org/download/${version}/composer.phar > ${phar}",
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    unless => "${binary} --version | grep -w '${version}' || [ ${PIPESTATUS[0]} == 139 ]",
    require => [File[$binary], File[$config]],
  }

  file {$binary:
    ensure => file,
    content => template("${module_name}/composer.sh"),
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {$config:
    ensure => file,
    content => template("${module_name}/composer.ini"),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
