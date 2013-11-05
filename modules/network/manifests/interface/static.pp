define network::interface::static (
  $device       = $name,
  $ipaddr,
  $netmask,
  $gateway      = undef,
  $hwaddr       = undef,
  $network      = undef,
  $slaves       = undef,
  $mtu          = undef,
  $bonding_opts = undef,
  $route_opts   = undef,
  $applyconfig  = true,
) {

  augeas {"main-$device" :
    context => "/files/etc/network/interfaces",
    changes => template('network/interface/static'),
  }

  if $applyconfig {
    exec {"/sbin/ifup $device":
      command => "/sbin/ifup $device",
      unless  => "/sbin/ifconfig | grep $device",
      path => ['/usr/local/bin', '/usr/bin', '/bin', '/sbin'],
    }
  }
}
