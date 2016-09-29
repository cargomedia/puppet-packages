define systemd::target(
  $critical = true,
  $purge = false,
) {
  $unit_name = "${name}.target"
  $unit_configuration = {
    'wanted_by' => 'multi-user.target'
  }

  systemd::unit { $unit_name:
    service_name => $unit_name,
    content  => template("${module_name}/unit.erb"),
    critical => $critical,
  }

  file { "/etc/systemd/system/${unit_name}.d":
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => $purge,
    recurse => true,
  }
}
