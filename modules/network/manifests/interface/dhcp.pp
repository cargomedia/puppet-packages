define network::interface::dhcp (
  $device       = $name,
  $applyconfig  = true,
) {

  augeas {"main-$device" :
    context => "/files/etc/network/interfaces",
    changes => template('network/interface/dhcp'),
  }

  if $applyconfig {
    exec {"/sbin/ifup $device":
      command => "/sbin/ifup $device",
      unless  => "/sbin/ifconfig | grep $device",
    }
  }
}
