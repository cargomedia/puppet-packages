class foreman {

  ruby::gem {'foreman':
    ensure => present,
  }
}
