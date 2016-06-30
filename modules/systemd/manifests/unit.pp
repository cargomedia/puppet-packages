define systemd::unit(
  $content,
  $start_on_create = true,
) {

  require 'systemd'
  include 'systemd::daemon_reload'

  $unless_start_on_create = $start_on_create ? {
    false => 'true',
    default => 'false',
  }

  file { "/etc/systemd/system/${name}.service":
    ensure  => file,
    content => $content,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify => Exec['systemctl daemon-reload'],
  }
  ~>

  # The unless clause will evaluate to *true* (do not execute) if $start_on_create is false
  exec { "systemctl start ${name}":
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless      => "${unless_start_on_create} || systemctl status ${name}",
    refreshonly => true,
  }

  Service <| title == $name |> {
    enable    => true,
    provider  => 'systemd',
    subscribe => File["/etc/systemd/system/${name}.service"],
  }
}
