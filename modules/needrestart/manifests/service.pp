define needrestart::service (
  $service_name = $name,
) {

  require 'needrestart'

  $service_needrestart_helper = "/usr/local/bin/needrestart-${service_name}"

  file { $service_needrestart_helper:
    ensure  => file,
    content => template("${module_name}/needrestart.sh.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
  ->

  apt::config { "999-needrestart-service-${service_name}":
    content => "DPkg::Post-Invoke {'${service_needrestart_helper}';};\n"
  }

}
