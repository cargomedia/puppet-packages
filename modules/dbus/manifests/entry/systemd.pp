define dbus::entry::systemd (
  $content
){

  include 'dbus'

  file { "/etc/dbus-1/system.d/${name}.conf":
    ensure  => file,
    content => template("${module_name}/systemd"),
    mode    => '0644',
    owner   => '0',
  }

}
