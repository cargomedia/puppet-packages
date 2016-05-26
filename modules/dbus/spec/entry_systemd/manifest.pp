node default {

  $policy = '
    <policy user="user-name">
      <allow send_destination="org.bluez"/>
      <allow send_interface="org.bluez.Manager"/>
      <allow send_interface="org.bluez.Agent"/>
      <allow send_interface="org.bluez.HandsfreeAgent"/>
      <allow send_interface="org.bluez.MediaEndpoint"/>
      <allow send_interface="org.bluez.MediaPlayer"/>
      <allow send_interface="org.bluez.Watcher"/>
      <allow send_interface="org.bluez.ThermometerWatcher"/>
    </policy>
  '

  dbus::entry::systemd { 'pulseaudio-system':
    content => $policy
  }
}
