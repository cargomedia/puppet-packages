class foreman::initd {

  ruby::gem {'foreman-export-initd':
    ensure => present,
  }
}
