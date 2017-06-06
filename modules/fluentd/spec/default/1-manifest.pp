node default {

  class { 'fluentd':
  }

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

  fluentd::config::match { 'my-dump':
    type     => 'file',
    pattern  => '**',
    priority => 99,
    config   => {
      path   => '/tmp/dump',
      format => 'json',
    },
  }
}
