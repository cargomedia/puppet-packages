class chromium::kiosk(
  $user,
  $url,
  $hide_ui = false,
  $pulseaudio = true,
) {

  require 'chromium'

  class { 'chromium::policy::homepage':
    url => $url,
  }

  $script = '/usr/local/bin/chromium-kiosk.sh'
  file { $script:
    ensure  => file,
    content => template("${module_name}/kiosk.sh.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
  }

  lightdm::xsession { 'chromium-kiosk':
    exec    => $script,
    require => File[$script],
  }

  class { 'lightdm::config::autologin':
    user => $user,
  }

  accountsservice::user { $user:
    xsession => 'chromium-kiosk',
  }

}
