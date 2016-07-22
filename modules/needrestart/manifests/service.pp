define needrestart::service {

  require 'needrestart'

  $service_needrestart_helper = "/path/to/needrestart-${name}"

  file { $service_needrestart_helper:
    ensure  => file,
    content => template("${module_name}/needrestart"),
  }
  ->

  apt::config { "needrestart-service-${name}":
    content => "DPkg::Post-Invoke {'${service_needrestart_helper}';};"
  }

}
