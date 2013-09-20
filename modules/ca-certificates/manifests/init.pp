class ca-certificates {

  package {'ca-certificates':
    ensure => present,
  }
}
