class bluetooth::bluez {

  package { ['bluez', 'bluez-alsa']:
    provider => apt,
  }
}
