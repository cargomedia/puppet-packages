class kernel::headers {

  package { "linux-headers-${::kernelrelease}":
    ensure   => present,
    provider => 'apt',
  }

}
