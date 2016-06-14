class kernel::headers {

  package { "linux-headers-${::facts['kernelrelease']}":
    ensure   => present,
    provider => 'apt',
  }

}
