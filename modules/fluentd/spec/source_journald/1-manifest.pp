node default {

  include 'fluentd'

  class { 'systemd::config::journald':
    fluentd_output => true,
  }

  fluentd::config::match_copy { 'dump_to_file':
    pattern  => '**',
    priority => 85,
    stores   => [{
      'type'   => 'file',
      'path'   => '/tmp/dump',
      'format' => 'json',
    }]
  }
}
