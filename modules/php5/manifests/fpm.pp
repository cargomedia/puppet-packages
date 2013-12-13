class php5::fpm {

  require 'php5'
  require 'apt::source::dotdeb'

  package {'php5-fpm':
    ensure => present,
  }

}
