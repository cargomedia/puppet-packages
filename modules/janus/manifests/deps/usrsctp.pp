class janus::deps::usrsctp {

  require 'git'
  package { ['libtool', 'automake']: }

  helper::script { 'install usrsctp':
    content => template("${module_name}/deps/usrsctp_install.sh"),
    unless  => 'ldconfig -v 2>/dev/null | grep -q libusrsctp',
    timeout => 900,
  }
}
