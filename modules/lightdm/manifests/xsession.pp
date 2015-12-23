define lightdm::xsession(
  $exec,
) {

  require 'lightdm'

  file { "/usr/share/xsessions/${title}.desktop":
    ensure  => file,
    content => template("${module_name}/xsession.desktop.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

}
