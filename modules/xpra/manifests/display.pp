define xpra::display (
  $extra_params = '--no-pulseaudio --no-mdns'
) {

  require 'xpra'

  daemon { "xpra-display-${name}":
    binary           => '/usr/bin/xpra',
    args             => "start :${name} --no-daemon ${extra_params}"
  }

}
