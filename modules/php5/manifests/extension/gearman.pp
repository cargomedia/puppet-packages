class php5::extension::gearman (
  $version = '1.1.2'
) {

  require 'build'
  require 'php5'
  require 'gearman::library_dev'

  helper::script {'install php5::extension::gearman':
    content => template("${module_name}/extension/gearman/install.sh"),
    unless => "php --re gearman | grep -w 'gearman version ${version}' || [ ${PIPESTATUS[0]} == 139 ]",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'gearman':
    content => template("${module_name}/extension/gearman/conf.ini"),
  }

}
