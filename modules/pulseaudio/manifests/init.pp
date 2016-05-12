class pulseaudio (
  $autospawn = false,
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
    user              => 'root',
    require           => [
      Package['pulseaudio'],
      User[$user],
    ]
  }
}
