define ufw::application(
  $app_name = $title,
  $app_title = $title,
  $app_description = $title,
  $app_ports,
){

  require 'ufw'

  file { "/etc/ufw/applications.d/${title}" :
    ensure  => file,
    content => template("${module_name}/application.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['ufw'],
  }
}
