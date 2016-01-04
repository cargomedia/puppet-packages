class xorg::server_utils {

  require 'apt'

  package { 'x11-xserver-utils':
    ensure   => present,
    provider => 'apt',
  }
}
