node default {

  class { 'fluentd':
  }

  fluentd::config::filters_grep { 'my-rules-src1':
    pattern  => 'src1.**',
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

  fluentd::config::filters_grep { 'my-rules-src2':
    pattern  => 'src2.**',
    priority => 22,
    rules    => {
      'remove_boo' => {
        regexp1 => 'unit boo',
        regexp2 => 'message toto',
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
