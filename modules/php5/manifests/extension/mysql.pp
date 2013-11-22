class php5::extension::mysql {

  require 'php5'

  package {'php5-mysql':
    ensure => present,
    require => Class['php5'],
  }
}
