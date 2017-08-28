class systemd::critical_units {

  Systemd::Critical_unit <||>

  service { 'critical-units.target':
    enable => true,
  }

  systemd::target { 'critical-units':
    critical => false,
    purge    => true,
  }

  $check_daemon_name = 'critical-units-check'

  file { "/usr/local/bin/${check_daemon_name}":
    ensure   => file,
    content  => template("${module_name}/monitoring/${check_daemon_name}.sh"),
    owner    => '0',
    group    => '0',
    mode     => '0755',
    notify   => Daemon[$check_daemon_name],
  }

  daemon { $check_daemon_name:
    binary  => "/usr/local/bin/${check_daemon_name}",
    require => File["/usr/local/bin/${check_daemon_name}"],
  }
}
