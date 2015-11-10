class janus::deps::libsrtp(
  $version = '1.5.0',
) {

  require 'build::pkg_config'

  helper::script { 'install libsrtp':
    content => template("${module_name}/deps/libsrtp_install.sh"),
    unless  => "pkg-config --modversion libsrtp | grep -qE '^${version}$'",
    timeout => 900,
  }
}
