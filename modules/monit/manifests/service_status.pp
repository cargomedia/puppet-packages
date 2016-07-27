define monit::service_status {

  $service_provider = $::facts['service_provider']

  if ($service_provider == 'systemd') {
    require 'monit::systemctl_status'
  }

  monit::entry { $title:
    content => template("${module_name}/entry/service-status.${service_provider}"),
  }
}
