class janus::deps::libsrtp(
  $version = '1.5.0',
  $build_tests = false,
) {

  helper::script { 'install libsrtp':
    content => template("${module_name}/deps/libsrtp_install.sh"),
    unless  => " ${version}$'",
    timeout => 900,
  }
}
