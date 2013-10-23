class php5::extension::memcache {

  require 'php5'

  package {'php5-memcache':
    ensure => present,
  }
}
