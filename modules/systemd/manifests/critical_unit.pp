define systemd::critical_unit {

  include 'systemd::daemon_reload'
  
  $unit_configuration = {
    'wants' => $name,
  }

  file { "/etc/systemd/system/critical-units.target.d/wants-${unit_configuration['wants']}.conf":
    ensure  => file,
    content => template('systemd/unit.erb'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }
}
