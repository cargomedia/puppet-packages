class php5::extension::runkit (
  $version = '1.0.4',
  $commit = '5e179e978af79444d3c877d5681ea91d15134a01'
) {

  require 'build'
  require 'php5'

  helper::script {'install php5::extension::runkit':
    content => template('php5/extension/runkit/install.sh'),
    unless => "php --re runkit | grep -w 'runkit version ${version}'",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'runkit':
    content => template('php5/extension/runkit/conf.ini'),
  }

}
