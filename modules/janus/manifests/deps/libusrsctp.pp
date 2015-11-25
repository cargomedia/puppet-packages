class janus::deps::libusrsctp(
  $version,
) {

  require 'git'
  require 'build::libtool'
  require 'build::automake'

  git::repository { 'usrsctp':
    remote      => 'https://github.com/sctplab/usrsctp',
    directory   => '/opt/src/janus-plugins/usrsctp',
    revision    => $version,
  }
  ~>

  helper::script { 'install libusrsctp':
    content => template("${module_name}/deps/libusrsctp_install.sh"),
    refresh_only => true,
    timeout => 900,
  }
}
