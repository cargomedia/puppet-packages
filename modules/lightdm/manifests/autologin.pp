class lightdm::autologin (
  $user,
) {

  require 'lightdm'

  file { '/etc/lightdm/lightdm.conf.d/99-autologin.conf':
    ensure  => file,
    content => template("${module_name}/autologin.conf.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }

}
