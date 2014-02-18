class php5::extension::xdebug {

  require 'php5'

  package {'php5-xdebug':
    ensure => present,
    require => Class['php5'],
  }
  ->

  # Original config "/etc/php5/conf.d/xdebug.ini" contains absolute path to "xdebug.so", so we don't touch it
  php5::config_extension {'xdebug-options':}

}
