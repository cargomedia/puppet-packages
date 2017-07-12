class fs::config::swapoff {

  $unit_name = 'swapoff.service'

  service { $unit_name:
    ensure => running,
    enable => true,
  }

  systemd::unit { $unit_name:
    service_name => $unit_name,
    critical => false,
    content => template("${module_name}/swapoff.service"),
  }

}
