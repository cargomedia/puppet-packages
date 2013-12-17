node default {

  require 'monit'

  class {'wowza::app::cm':
    archive_dir => '/tmp/archive',
    rpc_url => 'http://example.com/rpc',
  }

  exec {'start wowza':
    command => '/etc/init.d/wowza start',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    unless => '/etc/init.d/wowza status',
  }

}
