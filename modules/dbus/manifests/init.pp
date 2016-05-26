class dbus {

  require 'apt'

  package { 'dbus':
    provider => apt,
  }

  service { 'dbus':
    enable => true,
  }
}
