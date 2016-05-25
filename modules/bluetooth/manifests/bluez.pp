class bluetooth::bluez {

  package { ['bluez', 'bluez-alsa', 'bluez-cups']:
    provider => apt,
  }
}
