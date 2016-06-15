define pulseaudio::service (
  $user = 'root',
  $modules = undef,
  $post_command = undef,
) {

  require 'pulseaudio'

  if $modules {
    include prefix($modules, 'pulseaudio::module::')
  }

  $service_name = "pulseaudio-${user}"

  if (defined(User[$user])) {
    User[$user] -> Daemon[$service_name]
  }

  dbus::config::system { "pulseaudio-${user}":
    content => template("${module_name}/dbus")
  }

  daemon { $service_name:
    binary       => '/usr/bin/pulseaudio',
    args         => '--start --daemonize=false',
    user         => $user,
    post_command => $post_command,
  }
}
