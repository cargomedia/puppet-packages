class foreman::debian {

  ruby::gem {'foreman_debian':
    ensure => latest,
  }
}
