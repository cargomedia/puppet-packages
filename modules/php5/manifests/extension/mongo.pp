class php5::extension::mongo($version = '1.5.1') {

  require 'build'
  require 'php5'

  helper::script {'install php5::mongo':
    content => template('php5/extension/mongo/install.sh'),
    unless => "php --re mongo | grep 'mongo version' | grep ' ${version} '",
  }
  ->

  php5::config_extension {'mongo':
    content => template('php5/extension/mongo/conf.ini'),
  }
}
