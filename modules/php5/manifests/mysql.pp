class php5::mysql {

  require 'php5'

  package {'php5-mysql':
    ensure => present,
  }
}
