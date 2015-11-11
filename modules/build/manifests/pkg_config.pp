class build::pkg_config {

  package { 'pkg-config':
    ensure => present,
  }
}
