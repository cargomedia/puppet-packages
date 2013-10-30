class php5::extension::intl {

  require 'php5'

  package {'php5-intl':
    ensure => present,
    require => Class['php5'],
  }
}
