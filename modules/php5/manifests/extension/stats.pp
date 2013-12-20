class php5::extension::stats (
  $version = '1.0.3'
) {

  require 'build'
  require 'php5'

  helper::script {'install php5::extension::stats':
    content => template('php5/extension/stats/install.sh'),
    unless => "php --re stats | grep -w 'stats version ${version}'",
    require => Class['php5'],
  }
  ->

  file { '/etc/php5/conf.d/stats.ini':
    ensure => file,
    content => template('php5/extension/stats/conf.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }

}
