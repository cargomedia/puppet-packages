define pulseaudio::service (
  $user = 'root',
) {

  require 'pulseaudio'

  $service_name = "pulseaudio-${user}"

  if (defined(User[$user])) {
    User[$user] -> Daemon[$service_name]
  }

  daemon { $service_name:
    binary            => '/usr/bin/pulseaudio',
    args              => "--start --daemonize=false",
    user              => $user,
  }
}
