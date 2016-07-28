define needrestart::service (
  $service_name = $name,
) {

  require 'needrestart'

  apt::config { "999-needrestart-service-${service_name}":
    content => "DPkg::Post-Invoke {\"${needrestart::restart_helper_path} ${service_name}\";};\n"
  }
}
