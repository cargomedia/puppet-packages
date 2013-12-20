class php5::extension::gearman {

  require 'php5'

  package {'php5-gearman':
    ensure => present,
    require => Class['php5'],
  }
}
