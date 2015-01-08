class php5::extension::redis {

  $version = '2.2.3'
  require 'build'
  require 'php5'

  helper::script {'install php5-redis':
    content => template("${module_name}/extension/redis/install.sh"),
    unless => "php --ri redis | grep '^Redis Version => ${version}$' || [ ${PIPESTATUS[0]} == 139 ]",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'redis':
    content => template("${module_name}/extension/redis/conf.ini"),
  }

}
