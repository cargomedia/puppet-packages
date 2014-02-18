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

  php5::config_extension {'svm':
    content => template('php5/extension/svm/conf.ini'),
  }

}
