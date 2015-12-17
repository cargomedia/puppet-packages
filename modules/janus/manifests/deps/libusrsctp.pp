class janus::deps::libusrsctp {

  require 'git'
  require 'build::libtool'
  require 'build::automake'

  helper::script { 'install libusrsctp':
    content => template("${module_name}/deps/libusrsctp_install.sh"),
    unless  => 'ldconfig -v 2>/dev/null | grep -qE "libusrsctp\."',
    timeout => 900,
  }
}
