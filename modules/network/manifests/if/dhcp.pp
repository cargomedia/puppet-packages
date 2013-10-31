define network::if::dhcp (
  $device,
  $up = undef,
) {

  augeas {"main-$device" :
    context => "/files/etc/network/interfaces",
    changes => template('network/if/dhcp'),
  }

  if $up {
    exec {"/sbin/ifup $device":
      command => "/sbin/ifup $device",
      unless  => "/sbin/ifconfig | grep $device",
    }
  } else {
    exec {"/sbin/ifdown $device":
      command => "/sbin/ifconfig $device down",
      onlyif  => "/sbin/ifconfig | grep $device",
    }
  }
}
