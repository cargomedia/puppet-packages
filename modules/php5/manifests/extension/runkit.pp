class php5::extension::runkit (
  $version = '1.0.4'
) {

  require 'build'
  require 'php5'

  $commit = '5e179e978af79444d3c877d5681ea91d15134a01'

  helper::script {'install php5::extension::runkit':
    content => template('php5/extension/runkit/install.sh'),
    unless => "php --re runkit | grep -w 'runkit version ${version}'",
    require => Class['php5'],
  }
  ->

  file { '/etc/php5/conf.d/runkit.ini':
    ensure => file,
    content => template('php5/extension/runkit/conf.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }

}
