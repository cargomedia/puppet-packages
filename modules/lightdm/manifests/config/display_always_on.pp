class lightdm::config::display_always_on {

  require 'xorg::server_utils'

  lightdm::config { '50-display_always_on':
    content => template("${module_name}/config/display_always_on.conf.erb"),
  }

}
