define systemd::unit(
  $service_name,
  $content,
  $critical = true,
) {

  require 'systemd'
  include 'systemd::daemon_reload'

  file { "/etc/systemd/system/${name}":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }

  exec { "systemctl start ${name}":
    unless      => "systemctl is-active ${name}",
    subscribe   => [File["/etc/systemd/system/${name}"], Exec['systemctl daemon-reload']],
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  exec { "systemctl reload-or-restart ${name}":
    onlyif      => "systemctl is-active ${name}",
    subscribe   => [File["/etc/systemd/system/${name}"], Exec['systemctl daemon-reload']],
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  Service <| title == $service_name |> {
    enable    => true,
    provider  => 'systemd',
    subscribe => File["/etc/systemd/system/${name}"],
    before    => Exec["systemctl start ${name}"],
  }

  if ($critical) {
    @systemd::critical_unit { $name: }
  }
}
