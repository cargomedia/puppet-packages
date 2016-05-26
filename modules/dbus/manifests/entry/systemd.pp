define dbus::config::system (
  $content
){

  include 'dbus'

  file { "/etc/dbus-1/system.d/${name}.conf":
    ensure  => file,
    content => template("${module_name}/config_system"),
    mode    => '0644',
    owner   => '0',
  }

}
