class pulseaudio (
  $autospawn = false,
  $user = 'root',
  $daemon_binary = '/usr/bin/pulseaudio',
  $daemon_daemonize = false,
){

  package { 'pulseaudio':
    ensure   => installed,
    provider => apt,
  }

  file { '/etc/pulse/client.conf':
    ensure  => file,
    content => template("${module_name}/client"),
    mode    => '0644',
    owner   => 0,
    require => Package['pulseaudio'],
  }

  daemon { "pulseaudio-${user}":
    binary            => $daemon_binary,
    args              => "--start --daemonize=${daemon_daemonize}",
    user              => $user,
    require           => [
      Package['pulseaudio'],
    ]
  }
}
