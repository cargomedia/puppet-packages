class systemd::critical_units {
  
  file { '/etc/systemd/system/critical-units.target':
    ensure  => file,
    content => template("${module_name}/critical-units.target"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Exec['systemctl daemon-reload'],
  }

  file { '/etc/systemd/system/critical-units.target.wants/':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
  }
  
  Systemd::Critical_unit <||>
  
}
