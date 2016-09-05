define systemd::group(
  $critical = true,
  $purge = false,
) {

  systemd::unit { $name:
    content  => template("${module_name}/group.target"),
    critical => $critical,
  }

  file { "/etc/systemd/system/${name}.wants":
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => $purge,
    recurse => true,
  }
}
