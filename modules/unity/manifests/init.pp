class unity {

  include 'lightdm'

  package { ['unity', 'ubuntu-session']:
    ensure   => present,
    provider => 'apt',
  }

  ensure_packages(['gnome-terminal'], {
    provider => 'apt',
  })

  lightdm::xsession { 'ubuntu':
    exec    => 'gnome-session --session=ubuntu',
    entries  => {
      'DesktopNames' => 'Unity',
    },
    require => Package['unity'],
  }

}
