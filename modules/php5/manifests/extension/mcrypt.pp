class php5::extension::mcrypt {

  require 'php5'

  package {'php5-mcrypt':
    ensure => present,
    require => Class['php5'],
  }
}
