class php5::extension::mongo($version = '1.5.6') {

  require 'build'
  require 'php5'

  helper::script {'install php5::mongo':
    content => template("${module_name}/extension/mongo/install.sh"),
    unless => "php --re mongo | grep 'mongo version' | grep ' ${version} ' || [ ${PIPESTATUS[0]} == 139 ]",
  }
  ->

  php5::config_extension {'mongo':
    content => template("${module_name}/extension/mongo/conf.ini"),
  }
}
