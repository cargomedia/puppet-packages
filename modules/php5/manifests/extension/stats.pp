class php5::extension::stats (
  $version = '1.0.3'
) {

  require 'build'
  require 'php5'

  helper::script {'install php5::extension::stats':
    content => template("${module_name}/extension/stats/install.sh"),
    unless => "php --re stats | grep -w 'stats version ${version}' || [ ${PIPESTATUS[0]} == 139 ]",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'stats':
    content => template("${module_name}/extension/stats/conf.ini"),
  }

}
