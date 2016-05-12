class pulseaudio (
  $client_autospawn = false,
  $user = 'performer',
  $daemon_binary = '/usr/bin/pulseaudio',
  $daemon_daemonize = false,
){

  user { $user:
    ensure => present,
  }

  package { 'pulseaudio':
    ensure   => installed,
    provider => apt,
  }

  daemon { "pulseaudio-${user}":
    binary            => $daemon_binary,
    args              => "--start --daemonize=${daemon_daemonize}",
    user              => 'root',
    require           => [
      Package['pulseaudio'],
      User[$user],
    ]
  }
}
