define systemd::critical_unit (
  $serviceName
){

  include 'systemd::daemon_reload'

  file { "/etc/systemd/system/critical-units.target.wants/${serviceName}":
    ensure  => link,
    target  => "/etc/systemd/system/${serviceName}",
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }

}
