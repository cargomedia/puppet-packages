define pulseaudio::service (
  $user = 'root',
  $display,
  $xauthority,
  $xdg_runtime_dir,
) {

  require 'pulseaudio'

  $service_name = "pulseaudio-${user}"

  if (defined(User[$user])) {
    User[$user] -> Daemon[$service_name]
  }

  daemon { $service_name:
    binary => '/usr/bin/pulseaudio',
    args   => '--start --daemonize=false',
    user   => $user,
    env    => {
      'DISPLAY' => $display,
      'XAUTHORITY' => $xauthority,
      'XDG_RUNTIME_DIR' => $xdg_runtime_dir,
    }
  }
}
