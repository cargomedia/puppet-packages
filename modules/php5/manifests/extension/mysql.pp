class php5::extension::mysql {

  require 'apt'
  require 'php5'

  package { 'php5-mysql':
    provider => 'apt',
    ensure  => present,
    require => Class['php5'],
  }
}
