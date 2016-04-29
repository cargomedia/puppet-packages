class xorg (
  $config_path = '/etc/X11/xorg.conf'
) {

  require 'apt'

  package { 'xorg':
    ensure   => present,
    provider => 'apt',
  }

}
