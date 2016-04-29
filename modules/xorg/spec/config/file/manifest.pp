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

  $xorg_hid_config = '/etc/X11/xorg-multitouch.conf'

  xorg::config { 'set multitouch HID device - definition':
    section => 'InputClass',
    key     => 'MatchIsTouchpad',
    value   => 'true',
    config_path => $xorg_hid_config,
  }

  xorg::config { 'set multitouch HID device = identifier':
    section => 'InputClass',
    key     => 'Identifier',
    value   => 'Multitouch Touchpad',
    config_path => $xorg_hid_config,
  }

  xorg::config { 'set multitouch HID device - driver':
    section => 'InputClass',
    key     => 'Driver',
    value   => 'hid-multitouch',
    config_path => $xorg_hid_config,
  }
}
