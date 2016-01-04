class lightdm::config::autologin (
  $user,
) {

  lightdm::config {'99-autologin':
    content => template("${module_name}/config/autologin.conf.erb"),
  }

}
