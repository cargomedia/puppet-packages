class xorg::config::multitouch (
  $config_name = '50-multitouch'
){

  require 'apt'

  package { 'xserver-xorg-input-multitouch':
    ensure   => present,
    provider => 'apt',
  }

  xorg::config { 'multitouch support - definition':
    section     => 'InputClass',
    key         => 'MatchIsTouchpad',
    value       => '"true"',
    config_name => $config_name,
    require     => Package['xserver-xorg-input-multitouch'],
  }

  xorg::config { 'multitouch support - identifier':
    section     => 'InputClass',
    key         => 'Identifier',
    value       => 'Multitouch Touchpad',
    config_name => $config_name,
    require     => Package['xserver-xorg-input-multitouch'],
  }

  xorg::config { 'multitouch support - driver':
    section     => 'InputClass',
    key         => 'Driver',
    value       => 'hid-multitouch',
    config_name => $config_name,
    require     => Package['xserver-xorg-input-multitouch'],
  }
}
