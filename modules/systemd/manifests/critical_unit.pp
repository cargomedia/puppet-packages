define systemd::critical_unit {

  include 'systemd::daemon_reload'
  
  $wants = $name

  file { "/etc/systemd/system/critical-units.target.d/wants-${wants}.conf":
    ensure  => file,
    content => template('systemd/conf'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }
}
