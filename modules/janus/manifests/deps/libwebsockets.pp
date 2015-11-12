class janus::deps::libwebsockets(
  $version = '1.5',
) {

  require 'git'
  require 'build::cmake'
  require 'build::pkg_config'

  helper::script { 'install libwebsockets':
    content => template("${module_name}/deps/libwebsockets_install.sh"),
    unless  => "pkg-config --modversion libwebsockets | grep -qE '^${version}$'",
    timeout => 900,
  }
}
