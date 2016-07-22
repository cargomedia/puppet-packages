define needrestart::service {

  require 'needrestart'

  $service_needrestart_helper = "/usr/local/bin/needrestart-${name}"

  file { $service_needrestart_helper:
    ensure  => file,
    content => template("${module_name}/needrestart"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }
  ->

  apt::config { "needrestart-service-${name}":
    content => "DPkg::Post-Invoke {'${service_needrestart_helper}';};"
  }

}
