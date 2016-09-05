define systemd::unit(
  $content,
  $type = 'service',
  $critical = true,
) {
  
  $unit_name = "${name}.${type}"

  require 'systemd'
  include 'systemd::daemon_reload'

  file { "/etc/systemd/system/${unit_name}":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }
  ~>

  exec { "systemctl start ${unit_name}":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "systemctl status ${unit_name}",
    refreshonly => true,
  }

  Service <| title == $name |> {
    enable    => true,
    provider  => 'systemd',
    subscribe => File["/etc/systemd/system/${unit_name}"],
    before    => Exec["systemctl start ${unit_name}"],
  }
  
  if ($critical) {
    @systemd::critical_unit { $unit_name:
      unit_name => $unit_name,
    }
  }
}
