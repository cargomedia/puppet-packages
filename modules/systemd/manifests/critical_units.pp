class systemd::critical_units {

  Systemd::Critical_unit <||>

  service { 'critical-units.target':
    enable => true,
  }

  systemd::target { 'critical-units':
    critical => false,
    purge => true,
  }

  @bipbip::entry { 'critical-units-failing':
    plugin  => 'command-status',
    options => {
      'unit_name'    => 'critical-units.target',
      'metric_group' => 'critical-units-failing',
      'command' => 'for s in `sudo systemctl --plain list-dependencies critical-units.target | cut -d" " -f 2`;do if (sudo systemctl is-failed $s -q);then exit 1;fi;done;',
    },
  }

  @bipbip::entry { 'critical-units-stopped':
    plugin  => 'command-status',
    options => {
      'unit_name'    => 'critical-units.target',
      'metric_group' => 'critical-units-stopped',
      'command' => 'for s in `sudo systemctl --plain list-dependencies critical-units.target | cut -d" " -f 2`;do if ! ((sudo systemctl is-active $s -q) || (sudo systemctl is-failed $s -q));then exit 1;fi;done;',
    },
  }

  @sudo::config { 'systemctl-for-bipbip':
    content => 'bipbip ALL=NOPASSWD: /bin/systemctl',
  }
}
