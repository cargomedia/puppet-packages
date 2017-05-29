class systemd::critical_units {

  Systemd::Critical_unit <||>

  service { 'critical-units.target':
    enable => true,
  }

  systemd::target { 'critical-units':
    critical => false,
    purge => true,
  }

  @bipbip::entry { 'critical-units':
    plugin  => 'systemd-unit',
    options => {
      'unit_name'    => 'critical-units.target',
      'metric_group' => 'critical-units',
    },
  }
}
