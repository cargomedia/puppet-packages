class awscli ($version = '1.3.9') {

  package {'python-pip':
    ensure => installed,
  }
  ->

  package {'awscli':
    ensure => $version,
    provider => pip,
  }

}
