class php5::extension::imagick (
  $version = '3.1.2'
) {

  require 'build'
  require 'php5'

  package {'libmagickwand-dev':
    ensure => present,
  }
  ->

  helper::script {'install php5::extension::imagick':
    content => template('php5/extension/imagick/install.sh'),
    unless => "php --re imagick | grep -w 'imagick version ${version}'",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'imagick':
    content => template('php5/extension/imagick/conf.ini'),
  }

}
