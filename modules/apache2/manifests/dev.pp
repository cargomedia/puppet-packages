class apache2::dev {

  package{['apache2-threaded-dev', 'apache2-mpm-worker']:
    ensure => present,
  }

}
