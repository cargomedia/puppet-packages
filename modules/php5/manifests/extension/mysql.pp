class php5::extension::mysql {

  require 'apt'
  require 'php5'

  package { 'php5-mysql':
    ensure  => present,
    provider => 'apt',
    require => Class['php5'],
  }
}
