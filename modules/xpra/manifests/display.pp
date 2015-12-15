define xpra::display (
  $extra_params = '--no-daemon --no-pulseaudio --no-mdns'
) {

  include 'xpra'

  daemon { "xpra-display-$name":
    binary           => '/usr/bin/xpra',
    args             => "start :${name} ${extra_params}",
    require          => Class['xpra']
  }

}
