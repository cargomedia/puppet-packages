define systemd::target(
  $critical = true,
  $purge = false,
) {
  $unit_name = "${name}.target"

  systemd::unit{ $unit_name:
    content  => template("${module_name}/group.target"),
    critical => $critical,
  }

  file { "/etc/systemd/system/${unit_name}.wants":
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => $purge,
    recurse => true,
  }
}
