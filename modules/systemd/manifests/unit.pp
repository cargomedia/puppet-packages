define systemd::unit(
  $content,
  $type = 'service',
  $critical = true,
) {
  
  $unitName = "${name}.${type}"

  require 'systemd'
  include 'systemd::daemon_reload'

  file { "/etc/systemd/system/${unitName}":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }
  ~>

  exec { "systemctl start ${unitName}":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "systemctl status ${unitName}",
    refreshonly => true,
  }

  Service <| title == $name |> {
    enable    => true,
    provider  => 'systemd',
    subscribe => File["/etc/systemd/system/${unitName}"],
    before    => Exec["systemctl start ${unitName}"],
  }
  
  if ($critical) {
    @systemd::critical_unit { $unitName:
      unitName => $unitName,
    }
  }
}
