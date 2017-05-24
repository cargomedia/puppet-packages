node default {

  class { 'fluentd':
  }

  ## Sources

  fluentd::config::source { 'my-source-1':
    type   => 'tail',
    config => {
      path   => '/tmp/my-source-1',
      format => 'json',
      tag    => 'source1',
    },
  }

  file { '/tmp/my-source2':
    ensure => file,
    mode   => '0644',
    group  => '0',
    owner  => '0',
  }

  fluentd::config::source_tail { 'my-source-2':
    path        => '/tmp/my-source-2',
    fluentd_tag => 'source2',
    require     => File['/tmp/my-source2']
  }

  ## Filters

  fluentd::config::filter { 'my-filter-1':
    pattern => 'filter1.**',
    type    => 'grep',
    config  => {
      regexp1 => 'message cool',
    },
  }

  ## Matches

  fluentd::config::match { 'my-match-1':
    type     => 'file',
    priority => 50,
    pattern  => '**',
    config   => {
      path => '/tmp/my-match-1',
    },
  }

  fluentd::config::match { 'my-match-2':
    type     => 'file',
    priority => 49,
    pattern  => 'source2.**',
    config   => {
      path => '/tmp/my-match-2',
    },
  }

  fluentd::config::match_forest { 'my-forest-1':
    pattern  => '**',
    subtype  => 'file',
    template => {
      path => '/tmp/fluentd-forest-__TAG__.log',
    },
  }

}
