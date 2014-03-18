class apache2::dev {

  package{['apache2-threaded-dev']:
    ensure => present,
  }

}
