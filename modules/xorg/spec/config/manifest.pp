node default {

  xorg::config { 'add new module path 0':
    section => 'Files',
    key     => 'ModulePath',
    value   => '/tmp/0'
  }

  xorg::config { 'add new module path 0 - duplicate':
    section => 'Files',
    key     => 'ModulePath',
    value   => '/tmp/0'
  }

  xorg::config { 'add new module path 1':
    section => 'Files',
    key     => 'ModulePath',
    value   => '/tmp/1'
  }

  xorg::config { 'set device driver':
    section => 'Device',
    key     => 'Driver',
    value   => 'dummy'
  }

# HID multitouch example

  $hid_config_name = 'xorg-multitouch'

  xorg::config { 'set multitouch HID device - definition':
    section     => 'InputClass',
    key         => 'MatchIsTouchpad',
    value       => 0,
    config_name => $hid_config_name,
  }

  xorg::config { 'set multitouch HID device = identifier':
    section     => 'InputClass',
    key         => 'Identifier',
    value       => 'Multitouch Touchpad',
    config_name => $hid_config_name,
  }

  xorg::config { 'set multitouch HID device - driver':
    section     => 'InputClass',
    key         => 'Driver',
    value       => 'hid-multitouch',
    config_name => $hid_config_name,
  }
}
