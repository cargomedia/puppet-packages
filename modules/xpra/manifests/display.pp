define xpra::display (
  $extra_params = '--no-pulseaudio --no-mdns'
) {

  include 'xpra'

  daemon { "xpra-display-${name}":
    binary           => '/usr/bin/xpra',
    args             => "start :${name} --no-daemon ${extra_params}",
    require          => Class['xpra']
  }

}
