class php5::extension::mongodb($version = '1.2.0') {

  require 'build'
  require 'build::pkg_config'
  require 'php5'
  require 'openssl'

  helper::script { 'install php5::extension::mongodb':
    content => template("${module_name}/extension/mongodb/install.sh"),
    unless  => "php --re mongodb | grep 'mongodb version' | grep -q 'version ${version} ]'",
  }
  ->

  php5::config_extension { 'mongodb':
    content => template("${module_name}/extension/mongodb/conf.ini"),
  }
}
