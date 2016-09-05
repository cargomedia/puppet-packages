define systemd::critical_unit (
  $unit_name
){

  include 'systemd::daemon_reload'

  file { "/etc/systemd/system/critical-units.target.wants/${unit_name}":
    ensure  => link,
    target  => "/etc/systemd/system/${unit_name}",
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }

}
