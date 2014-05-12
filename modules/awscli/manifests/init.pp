class awscli ($version = '1.3.9') {

  python::pip {'awscli':
    ensure => $version,
  }

}
