class php5::extension::svm (
  $version = '0.1.9',
  $version_output = '0.1.6'
) {

  require 'build'
  require 'php5'

  package {['libsvm-dev', 're2c']:
    ensure => present,
  }
  ->

  helper::script {'install php5::extension::svm':
    content => template('php5/extension/svm/install.sh'),
    unless => "php --re svm | grep -w 'svm version ${version_output}'",
    require => Class['php5'],
  }
  ->

  file { '/etc/php5/conf.d/svm.ini':
    ensure => file,
    content => template('php5/extension/svm/conf.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }

}
