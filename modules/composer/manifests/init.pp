class composer($version = '1.2.1') {

  require 'php5'

  $phar = '/usr/local/lib/composer.phar'
  $binary = '/usr/local/bin/composer'

  exec { "curl ${phar}":
    command => "curl -sL http://getcomposer.org/download/${version}/composer.phar > ${phar}",
    path    => ['/usr/local/bin', '/usr/bin', '/bin'],
    unless  => "${binary} --version | grep -qw 'Composer version ${version}'",
    require => [File[$binary]],
    environment => ['HOME=sweet_home'],
  }

  file { $binary:
    ensure  => file,
    content => template("${module_name}/composer.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

}
