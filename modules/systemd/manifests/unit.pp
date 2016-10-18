define systemd::unit(
  $service_name,
  $content,
  $critical = true,
) {

  require 'systemd'

  file { "/etc/systemd/system/${name}":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Systemd::Daemon_reload[$name],
  }

  exec { "systemctl start ${name}":
    unless      => "systemctl is-active ${name}",
    subscribe   => File["/etc/systemd/system/${name}"],
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  Service <| title == $service_name |> {
    enable      => true,
    provider    => 'systemd',
    subscribe   => File["/etc/systemd/system/${name}"],
    before      => Exec["systemctl start ${name}"],
    require     => Systemd::Daemon_reload[$name],
  }

  systemd::daemon_reload { $name: }

  if ($critical) {
    @systemd::critical_unit { $name: }
  }
}
