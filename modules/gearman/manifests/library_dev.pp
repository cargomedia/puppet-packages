class gearman::library_dev {

  require 'apt'
  require 'apt::source::cargomedia'

  package { 'libgearman-dev':
    ensure   => present,
    provider => 'apt',
    require  => Class['apt::source::cargomedia'],
  }

}
