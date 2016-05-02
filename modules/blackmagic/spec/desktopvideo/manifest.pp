node default {

  require 'monit'

  class { 'blackmagic::desktopvideo':
  }

}
