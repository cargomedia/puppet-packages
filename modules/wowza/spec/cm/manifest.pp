node default {

  require 'monit'
  require 'wowza::app::cm'

  exec {'start wowza':
    command => '/etc/init.d/wowza start',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless => '/etc/init.d/wowza status',
  }

}
