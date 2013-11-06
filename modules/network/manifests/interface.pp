define network::interface (
  $device       = $name,
  $method       = undef,
  $ipaddr       = undef,
  $netmask      = undef,
  $gateway      = undef,
  $hwaddr       = undef,
  $network      = undef,
  $slaves       = undef,
  $mtu          = undef,
  $bonding_opts = undef,
  $route_opts   = undef,
  $wpa_ssid     = undef,
  $wpa_psk      = undef,
  $applyconfig  = true,
) {

  case $method {
    'dhcp': {
      augeas {"main-$device" :
        context => "/files/etc/network/interfaces",
        changes => template('network/interface/dhcp'),
      }
    }
    'static': {
      if $ipaddr == undef {
        fail('no ip')
      }
      if $netmask == undef {
        fail('no netmask')
      }
      augeas {"main-$device" :
        context => "/files/etc/network/interfaces",
        changes => template('network/interface/static'),
      }
    }
    default: {
      fail("Unknown method ${method}")
    }
  }

  if $applyconfig {
    exec {"/sbin/ifup $device":
      command => "/sbin/ifup $device",
      unless  => "/sbin/ifconfig | grep $device",
      path => ['/usr/local/bin', '/usr/bin', '/bin', '/sbin'],
    }
  }
}
