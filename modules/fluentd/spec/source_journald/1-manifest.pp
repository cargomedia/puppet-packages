node default {

  include 'fluentd'

  class { 'systemd::config::journald': }

  file { '/tmp/my-source':
    ensure => file,
    mode   => '0644',
    group  => '0',
    owner  => '0',
  }

  fluentd::config::source_tail { 'my-source':
    path        => '/tmp/my-source',
    fluentd_tag => 'source',
    format      => '/foo (?<message>.+)/',
    require     => File['/tmp/my-source'],
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
