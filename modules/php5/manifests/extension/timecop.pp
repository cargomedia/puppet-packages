class php5::extension::timecop (
  $version = '1.2.6'
) {

  require 'build'
  require 'php5'
  require 'git'

  helper::script { 'install php5::extension::timecop':
    content => template("${module_name}/extension/timecop/install.sh"),
    unless  => "php --re timecop | grep -w 'timecop version ${version}'",
    require => Class['php5', 'git'],
  }
  ->

  php5::config_extension { 'timecop':
    content => template("${module_name}/extension/timecop/conf.ini"),
  }

}
