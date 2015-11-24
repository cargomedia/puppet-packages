class php5::extension::mcrypt {

  require 'apt'
  require 'php5'

  package { 'php5-mcrypt':
    provider => 'apt',
    ensure  => present,
    require => Class['php5'],
  }
}
