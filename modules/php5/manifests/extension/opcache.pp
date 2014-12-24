class php5::extension::opcache (
  $version = '7.0.3',
  $version_output = '7.0.3FE',
  $enable = true,
  $enable_cli = false,
  $memory_consumption = 256, # in Mbytes
  $interned_strings_buffer = 8, # in Mbytes
  $max_accelerated_files = 4000,
  $fast_shutdown = true,
  $validate_timestamps = false
) {

  require 'build'
  require 'php5'

  helper::script {'install php5::extension::opcache':
    content => template("${module_name}/extension/opcache/install.sh"),
    unless => "php --re 'Zend OPcache' | grep 'Zend OPcache version ${version_output} ' || [ ${PIPESTATUS[0]} == 139 ]",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'opcache':
    content => template("${module_name}/extension/opcache/conf.ini"),
  }

  Php5::Fpm::With_opcache <||>
}
