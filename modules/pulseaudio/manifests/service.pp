define pulseaudio::service (
  $user = 'root',
) {

  require 'pulseaudio'

  $service_name = "pulseaudio-${user}"

  if (defined(User[$user])) {
    User[$user] -> Daemon[$service_name]
  }

  dbus::entry::systemd { "pulseaudio-system-${user}":
    content => template("${module_name}/dbus")
  }

  daemon { $service_name:
    binary => '/usr/bin/pulseaudio',
    args   => '--start --daemonize=false',
    user   => $user,
  }
}
