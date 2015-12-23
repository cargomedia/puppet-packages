class php5::extension::runkit (
  $version = '1.0.4'
) {

  require 'build'
  require 'php5'
  require 'git'

  helper::script { 'install php5::extension::runkit':
    content => template("${module_name}/extension/runkit/install.sh"),
    unless  => "php --re runkit | grep -w 'runkit version ${version}'",
    require => Class['php5', 'git'],
  }
  ->

  php5::config_extension { 'runkit':
    content => template("${module_name}/extension/runkit/conf.ini"),
  }

}
