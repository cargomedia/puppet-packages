class php5::extension::opcache (
  $version = '7.0.3'
) {

  require 'build'
  require 'php5'

  helper::script {'install php5::extension::opcache':
    content => template('php5/extension/opcache/install.sh'),
    unless => "php --re opcache | grep 'opcache version' | grep ' ${version} '",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'opcache':
    content => template('php5/extension/opcache/conf.ini'),
  }
}
