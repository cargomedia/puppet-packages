node default {
  class { [
    'build::dev::libglib2',
    'build::dev::libjansson',
    'build::dev::zlib1g',
    'build::automake',
    'build::cmake',
    'build::libtool',
    'build::pkg_config',
  ]: }
}
