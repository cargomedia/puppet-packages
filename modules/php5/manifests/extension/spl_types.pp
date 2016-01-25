class php5::extension::spl_types (
  $version = '0.4.0'
) {

  require 'build'
  require 'php5'

  helper::script { 'install php5::extension::spl_types':
    content => template("${module_name}/extension/spl_types/install.sh"),
    unless  => "php --re SPL_Types | grep -w 'SPL_Types version ${version}'",
    require => Class['php5'],
  }
  ->

  php5::config_extension { 'spl_types':
    content => template("${module_name}/extension/spl_types/conf.ini"),
  }

}
