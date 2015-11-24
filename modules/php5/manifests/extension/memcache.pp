class php5::extension::memcache {

  require 'apt'
  require 'php5'

  package { 'php5-memcache':
    provider => 'apt',
    ensure  => present,
    require => Class['php5'],
  }
  ->

  php5::config_extension { 'memcache':
    content => template("${module_name}/extension/memcache/conf.ini"),
  }

}
