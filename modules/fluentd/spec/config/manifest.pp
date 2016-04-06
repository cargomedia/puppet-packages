node default {

  class { 'fluentd':
  }

  ## Source

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

  fluentd::config::source_tail{ 'my-source-3':
    path        => '/tmp/foo3',
    fluentd_tag => 'my-source',
  }

  fluentd::config::source_tail{ 'my-source-4':
    path        => '/tmp/foo4',
    fluentd_tag => 'my-source',
  }

  ## Match

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

  fluentd::config::match_forest{ 'my-forest-1':
    pattern  => '**',
    subtype  => 'file',
    template => {
      path => '/tmp/fluentd-forest-__TAG__.log',
    },
  }

  ## Filter

  fluentd::config::filter{ 'my-filter-1':
    pattern  => 'filter1.**',
    type     => 'grep',
    config   => {
      regexp1   => 'message cool',
    },
  }

  fluentd::config::filter_record_transformer{ 'my-hostname':
    pattern  => '**',
    record   => {
      hostname => $::fqdn,
    },
    priority => 1,
  }

}
