class bluetooth::bluez {

  require 'apt'

  package { ['bluez', 'bluez-alsa']:
    provider => apt,
  }
}
