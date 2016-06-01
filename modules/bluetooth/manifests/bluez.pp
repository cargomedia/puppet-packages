class bluetooth::bluez {

  require 'apt'

  package { ['bluez', 'bluez-alsa', 'bluez-tools']:
    provider => apt,
  }
}
