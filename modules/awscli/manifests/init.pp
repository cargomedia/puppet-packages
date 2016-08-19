class awscli {

  python::pip { 'awscli':
    ensure => present,
  }

}
