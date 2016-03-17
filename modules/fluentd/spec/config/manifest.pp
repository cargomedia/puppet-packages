node default {

  class { 'fluentd':
  }

  fluentd::config::source{ 'my-source-1':
    type     => 'tail',
    config   => {
      path   => '/tmp/my-source-1',
      format => 'syslog',
      tag    => 'source1',
    },
    priority => 1,
  }

  fluentd::config::source{ 'my-source-2':
    type     => 'tail',
    config   => {
      path   => '/tmp/my-source-2',
      format => 'syslog',
      tag    => 'source2',
    },
    priority => 2,
  }

  fluentd::config::match{ 'my-match-1':
    type     => 'file',
    pattern  => 'match1.**',
    config   => {
      path   => '/tmp/my-match-1',
    },
  }

  fluentd::config::match{ 'my-match-2':
    type     => 'file',
    pattern  => '**',
    config   => {
      path   => '/tmp/my-match-2',
    },
    priority => 99,
  }

}
