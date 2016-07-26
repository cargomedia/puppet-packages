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
    notify  => Exec['systemctl daemon-reload'],
  }

  Service <| title == $name |> {
    enable    => true,
    ensure    => running,
    provider  => 'systemd',
    subscribe => File["/etc/systemd/system/${name}.service"],
  }
}
