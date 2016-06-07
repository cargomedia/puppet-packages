define systemd::unit(
  $content,
) {

  require 'systemd'
  include 'systemd::daemon_reload'

  file { "/etc/systemd/system/${name}.service":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => [
      Exec['systemctl daemon-reload'],
      Exec["systemctl start ${name}"],
      Exec["systemctl enable ${name}"],
    ]
  }

  exec { "systemctl start ${name}":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "systemctl status ${name}",
    refreshonly => true,
  }

  exec { "systemctl enable ${name}":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  Service <| title == $name |> {
    enable    => true,
    provider  => 'systemd',
    subscribe => File["/etc/systemd/system/${name}.service"],
  }
}
