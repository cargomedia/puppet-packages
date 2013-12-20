class php5::extension::memcache {

  require 'php5'

  package {'php5-memcache':
    ensure => present,
    require => Class['php5'],
  }
  ->

  file {'/etc/php5/conf.d/memcache.ini':
    ensure => file,
    content => template('php5/extension/memcache/conf.ini'),
    owner => '0',
    group => '0',
    mode => '0644',
  }
}
