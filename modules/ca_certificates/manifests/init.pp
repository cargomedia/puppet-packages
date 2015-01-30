class ca_certificates {

  package { 'ca-certificates':
    ensure => present,
  }
}
