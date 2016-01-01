node default {

  class { 'lightdm::config::display_always_on':
  }
  ->

  exec { 'start lightdm':
    command     => '/bin/systemctl start lightdm',
  }

}
