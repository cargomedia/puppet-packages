class php5::extension::xdebug {

  require 'php5'

  package {'php5-xdebug':
    ensure => present,
    require => Class['php5'],
  }
  ->

  file { '/etc/php5/conf.d/xdebug-options.ini':
    ensure => file,
    content => template('php5/extension/xdebug/conf.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
