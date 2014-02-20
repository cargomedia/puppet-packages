class php5::extension::xdebug(
  $remote_host = 'localhost',
  $remote_port = 9000,
  $remote_connect_back = true,
  $remote_autostart = false
) {

  require 'php5'

  $remote_autostart_int = $remote_autostart ? {true => 1, false => 0}
  $remote_connect_back_int = $remote_connect_back ? {true => 1, false => 0}

  package {'php5-xdebug':
    ensure => present,
    require => Class['php5'],
  }
  ->

  # Original config "/etc/php5/conf.d/xdebug.ini" contains absolute path to "xdebug.so", so we don't touch it
  php5::config_extension {'xdebug-options':
    content => template('php5/extension/xdebug-options/conf.ini'),
  }
}
