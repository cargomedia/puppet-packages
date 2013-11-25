class php5::extension::curl {

  require 'php5'

  package {'php5-curl':
    ensure => present,
  }
}
