class gearman::library_dev {

  require 'apt'
  require 'apt::source::cargomedia'

  package { 'libgearman-dev':
    provider => 'apt',
    ensure  => present,
    require => Class['apt::source::cargomedia'],
  }

}
