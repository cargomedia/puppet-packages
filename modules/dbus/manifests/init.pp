class dbus {

  require 'apt'

  package { 'dbus':
    provider => apt,
  }

}
