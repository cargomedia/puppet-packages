class php5::extension::memcache {

  require 'php5'

  package {'php5-memcache':
    ensure => present,
    require => Class['php5'],
  }
}
