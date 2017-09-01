class goreplay::unit (
  $input,
  $output   = 'stdout',
  $duration = '0',
)
{
  $unit_name = 'goreplay'

  require $unit_name

  service { $unit_name:
    enable => true,
  }

  systemd::unit { "${unit_name}.service":
    service_name => $unit_name,
    critical => false,
    content => template("${module_name}/goreplay.service.erb"),
  }
}
