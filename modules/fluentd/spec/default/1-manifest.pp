node default {

  class { 'fluentd':
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
