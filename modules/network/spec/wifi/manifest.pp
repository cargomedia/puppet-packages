node default {

  network::interface {'eth1':
    method    => 'dhcp',
    wpa_ssid  => 'foo',
    wpa_psk   => 'bar',
    applyconfig => false
  }
}
