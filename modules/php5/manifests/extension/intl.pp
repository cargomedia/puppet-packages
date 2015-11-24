class php5::extension::intl {

  require 'apt'
  require 'php5'

  package { 'php5-intl':
    ensure  => present,
    provider => 'apt',
    require => Class['php5'],
  }
}
