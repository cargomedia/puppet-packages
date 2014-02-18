class php5::extension::stats (
  $version = '1.0.3'
) {

  require 'build'
  require 'php5'

  helper::script {'install php5::extension::stats':
    content => template('php5/extension/stats/install.sh'),
    unless => "php --re stats | grep -w 'stats version ${version}'",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'stats':
    content => template('php5/extension/stats/conf.ini'),
  }

}
