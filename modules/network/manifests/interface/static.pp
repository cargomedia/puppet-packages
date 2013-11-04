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
) {

  notify{"$name": message => $opts}

  augeas {"main-$device" :
    context => "/files/etc/network/interfaces",
    changes => template('network/interface/static'),
  }

#  if $up {
#    exec {"/sbin/ifup $device":
#      command => "/sbin/ifup $device",
#      unless  => "/sbin/ifconfig | grep $device",
#      path => ['/usr/local/bin', '/usr/bin', '/bin', '/sbin'],
#    }
#  } else {
#    exec {"/sbin/ifdown $device":
#      command => "/sbin/ifconfig $device down",
#      onlyif  => "/sbin/ifconfig | grep $device",
#      path => ['/usr/local/bin', '/usr/bin', '/bin', '/sbin'],
#    }
#  }
}
