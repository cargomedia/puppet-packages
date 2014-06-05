class foreman::debian {

  ruby::gem {'foreman_debian':
    ensure => '0.0.7',
  }
}
