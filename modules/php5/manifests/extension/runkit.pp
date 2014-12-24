class php5::extension::runkit (
  $version = '1.0.4',
  $commit = '5e179e978af79444d3c877d5681ea91d15134a01'
) {

  require 'build'
  require 'php5'
  require 'git'

  helper::script {'install php5::extension::runkit':
    content => template("${module_name}/extension/runkit/install.sh"),
    unless => "php --re runkit | grep -w 'runkit version ${version}' || [ ${PIPESTATUS[0]} == 139 ]",
    require => Class['php5', 'git'],
  }
  ->

  php5::config_extension {'runkit':
    content => template("${module_name}/extension/runkit/conf.ini"),
  }

}
