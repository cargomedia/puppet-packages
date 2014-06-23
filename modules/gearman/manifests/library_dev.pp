class gearman::library_dev {

  require 'apt::source::cargomedia'

  package {'libgearman-dev':
    ensure => present,
  }

}
