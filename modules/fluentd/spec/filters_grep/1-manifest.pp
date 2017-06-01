node default {

  class { 'fluentd':
  }

  fluentd::config::filters_grep { 'my-rules':
    pattern  => '**',
    priority => 22,
    rules    => {
      'remove_bar'      => {
        exclude1 => 'message bar'
      },
      'keep_level_warn' => {
        regexp1 => 'level warning',
      },
    },
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
