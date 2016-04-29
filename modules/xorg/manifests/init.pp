class xorg (
  $config_path = '/etc/X11/xorg.conf',
  $config_path_dir = '/etc/X11/xorg.conf.d'
) {

  require 'apt'

  package { 'xorg':
    ensure   => present,
    provider => 'apt',
  }

  file { $config_path_dir:
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => Package['xorg']
  }

}
