node default {

  require 'monit'

  class {'wowza::app::cm':
    cm_bin_path => '/tmp/my-bin',
    rpc_url => 'http://example.com/rpc',
  }
}
