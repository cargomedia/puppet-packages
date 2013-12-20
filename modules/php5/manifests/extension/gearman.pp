class php5::extension::gearman (
  $version = '1.1.0'
) {

  require 'build'
  require 'php5'
  require 'gearmand'

  helper::script {'install php5::extension::gearman':
    content => template('php5/extension/gearman/install.sh'),
    unless => "php --re gearman | grep -w 'gearman version ${version}'",
    require => Class['php5'],
  }
  ->

  file { '/etc/php5/conf.d/gearman.ini':
    ensure => file,
    content => template('php5/extension/gearman/conf.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }

}
