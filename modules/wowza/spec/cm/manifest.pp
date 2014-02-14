node default {

  require 'monit'

  class {'wowza::app::cm':
    archive_dir => '/tmp/archive',
    rpc_url => 'http://example.com/rpc',
  }
}
