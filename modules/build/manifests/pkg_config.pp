class build::pkg_config {

  require 'apt'

  package { 'pkg-config':
    ensure => present,
    provider => 'apt',
  }
}
