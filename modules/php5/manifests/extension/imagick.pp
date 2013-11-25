class php5::extension::imagick {

  require 'php5'

  package {'php5-imagick':
    ensure => present,
  }
}
