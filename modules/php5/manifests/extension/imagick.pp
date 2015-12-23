class php5::extension::imagick (
  $version = '3.1.2'
) {

  require 'apt'
  require 'build'
  require 'php5'

  package { 'libmagickwand-dev':
    ensure   => present,
    provider => 'apt',
  }
  ->

  helper::script { 'install php5::extension::imagick':
    content => template("${module_name}/extension/imagick/install.sh"),
    unless  => "php --re imagick | grep -w 'imagick version ${version}'",
    require => Class['php5'],
  }
  ->

  php5::config_extension { 'imagick':
    content => template("${module_name}/extension/imagick/conf.ini"),
  }

}
