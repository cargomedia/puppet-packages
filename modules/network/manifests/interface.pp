define network::interface (
  $device       = $name,
  $method,
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
  $snat = false,
) {

  include 'augeas'

  case $method {
    'dhcp': {
      augeas { "main-${device}" :
        context => '/files/etc/network/interfaces',
        changes => template("${module_name}/interface/dhcp"),
        require => Class['augeas'],
      }
    }
    'static': {
      if $ipaddr == undef {
        fail ("IP address for interface ${device} must be specified for ${method} method!")
      }
      if $netmask == undef {
        fail ("Netmask for interface ${device} must be specified for ${method} method!")
      }
      augeas { "main-${device}" :
        context => '/files/etc/network/interfaces',
        changes => template("${module_name}/interface/static_manual"),
        require => Class['augeas'],
      }
    }
    'manual': {
      augeas { "main-${device}" :
        context => '/files/etc/network/interfaces',
        changes => template("${module_name}/interface/static_manual"),
        require => Class['augeas'],
      }
    }
    default: {
      fail ("Unknown method ${method} for interface ${device}!")
    }
  }

  if $applyconfig {
    exec { "Restart ${device}":
      command     => "ifdown --force ${device} && ifup ${device}",
      path        => ['/bin', '/sbin', '/usr/bin'],
      refreshonly => true,
      subscribe   => Augeas["main-${device}"],
    }
  }

  if $snat {
    $network_interface = regsubst($device, '^([a-z]+\d?)(:?.?)*$', '\1')
    network::snat { "SNAT on ${network_interface}":
      interface => $network_interface,
      source_address => $ipaddr,
    }
  }
}
