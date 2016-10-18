define systemd::critical_unit {

  $unit_configuration = {
    'wants' => $name,
  }

  file { "/etc/systemd/system/critical-units.target.d/wants-${unit_configuration['wants']}.conf":
    ensure  => file,
    content => template('systemd/unit.erb'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }
  ~>

  systemd::daemon_reload { "critical-unit restart ${name}": }
}
