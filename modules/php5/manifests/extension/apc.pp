class php5::extension::apc (
  $version = '3.1.13',
  $stat = true,
  $shim_size = '256M',
  $enable_cli = true,
  $cache_by_default = true,
  $configureParams = '--enable-apc-mmap --enable-apc-pthreadmutex --disable-apc-debug --disable-apc-filehits --disable-apc-spinlocks'
) {

  require 'build'
  require 'php5'

  helper::script {'install php5::apc':
    content => template("${module_name}/extension/apc/install.sh"),
    unless => "php --re apc | grep 'apc version' | grep ' ${version} ' || [ ${PIPESTATUS[0]} == 139 ]",
    require => Class['php5'],
  }
  ->

  php5::config_extension {'apc':
    content => template("${module_name}/extension/apc/conf.ini"),
  }

  Php5::Fpm::With_apc <||>
}
