class php5::extension::intl {

  require 'apt'
  require 'php5'

  package { 'php5-intl':
    provider => 'apt',
    ensure  => present,
    require => Class['php5'],
  }
}
