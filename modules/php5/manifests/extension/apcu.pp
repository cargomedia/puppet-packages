class php5::extension::apcu (
  $version = '4.0.4',
  $shm_size = '256M',
  $enable_cli = true,
  $mmap_file_mask = '/tmp/apc.XXXXXX',
  $configureParams = ''
) {

  require 'build'
  require 'php5'

  helper::script { 'install php5::apcu':
    content => template("${module_name}/extension/apcu/install.sh"),
    unless  => "php --re apcu | grep 'apcu version' | grep ' ${version} '",
    require => Class['php5'],
  }
  ->

  php5::config_extension { 'apcu':
    content => template("${module_name}/extension/apcu/conf.ini"),
  }

  Php5::Fpm::With_apc <||>
}
