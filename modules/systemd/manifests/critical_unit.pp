define systemd::critical_unit {

  include 'systemd::daemon_reload'

  file { "/etc/systemd/system/critical-units.target.wants/${name}":
    ensure  => link,
    target  => "/etc/systemd/system/${name}",
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }

}
