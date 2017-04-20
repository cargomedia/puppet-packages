node default {

  class { 'fluentd':
  }

  ## Source

  fluentd::config::source{ 'my-source-1':
    type     => 'tail',
    config   => {
      path   => '/tmp/my-source-1',
      format => 'json',
      tag    => 'source1',
    },
  }

  fluentd::config::source_tail{ 'my-source-2':
    path        => '/tmp/my-source-2',
    fluentd_tag => 'source2',
  }

  ## Filter

  include 'fluentd::config::filter_add_hostname'
  include 'fluentd::config::filter_streamline_levels'

  fluentd::config::filter{ 'my-filter-1':
    pattern  => 'filter1.**',
    type     => 'grep',
    config   => {
      regexp1   => 'message cool',
    },
  }

  ## Match

  fluentd::config::match{ 'my-match-1':
    type     => 'file',
    priority => 50,
    pattern  => '**',
    config   => {
      path   => '/tmp/my-match-1',
    },
  }

  fluentd::config::match{ 'my-match-2':
    type     => 'file',
    priority => 49,
    pattern  => 'source2.**',
    config   => {
      path   => '/tmp/my-match-2',
    },
  }


  fluentd::config::match_forest{ 'my-forest-1':
    pattern  => '**',
    subtype  => 'file',
    template => {
      path => '/tmp/fluentd-forest-__TAG__.log',
    },
  }

}
