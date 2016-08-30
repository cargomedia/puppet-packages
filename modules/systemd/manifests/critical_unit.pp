define systemd::critical_unit (
  $unitName
){

  include 'systemd::daemon_reload'

  file { "/etc/systemd/system/critical-units.target.wants/${unitName}":
    ensure  => link,
    target  => "/etc/systemd/system/${unitName}",
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }

}
