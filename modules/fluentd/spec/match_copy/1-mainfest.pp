node default {

  class { 'fluentd':
  }

  fluentd::config::source { 'my-source-1':
    type   => 'tail',
    config => {
      path   => '/tmp/my-source-1',
      format => 'json',
      tag    => 'source1',
    },
  }

  fluentd::config::match_copy { 'my-copy-1':
    pattern => '**',
    stores  => [{
      'type'   => 'file',
      'path'   => '/tmp/dump1',
      'format' => 'json',
    }, {
      'type'   => 'file',
      'path'   => '/tmp/dump2',
      'format' => 'hash',
    }]
  }

}
