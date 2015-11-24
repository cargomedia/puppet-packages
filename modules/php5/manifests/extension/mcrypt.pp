class php5::extension::mcrypt {

  require 'apt'
  require 'php5'

  package { 'php5-mcrypt':
    ensure  => present,
    provider => 'apt',
    require => Class['php5'],
  }
}
