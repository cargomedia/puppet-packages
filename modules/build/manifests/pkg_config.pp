class build::pkg_config {

  require 'apt'

  package { 'pkg-config':
    provider => 'apt',
  }
}
