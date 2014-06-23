class gearman::library {

  require 'apt::source::cargomedia'

  package {'libgearman7':
    ensure => present,
  }

}
