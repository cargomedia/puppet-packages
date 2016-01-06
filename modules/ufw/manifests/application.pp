define ufw::application(
  $app_name = $title,
  $app_title = $title,
  $app_description = $title,
  $app_ports,
){

  require 'ufw'

  file { "/etc/ufw/applications.d/${app_name}" :
    ensure  => file,
    content => template("${module_name}/application.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['ufw'],
  }
  ->

  ufw::rule { "Allow ${app_name}":
    app_or_port => $app_name,
  }
}
