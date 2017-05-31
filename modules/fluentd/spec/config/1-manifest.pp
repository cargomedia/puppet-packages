node default {

  class { 'fluentd':
  }

  ## Sources

  file { '/tmp/my-source-1':
    ensure  => file,
    mode    => '0644',
    content => "{\"message\":\"BAR\",\"level\":\"notice\"}\n",
    group   => '0',
    owner   => '0',
  }

  fluentd::config::source { 'my-source-1':
    type   => 'tail',
    config => {
      path           => '/tmp/my-source-1',
      format         => 'json',
      tag            => 'source1',
      read_from_head => true,
    },
  }

  file { '/tmp/my-source-2':
    ensure => file,
    mode   => '0644',
    group  => '0',
    owner  => '0',
  }

  fluentd::config::source_tail { 'my-source-2':
    path        => '/tmp/my-source-2',
    fluentd_tag => 'source2',
    require     => File['/tmp/my-source-2']
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
    priority => 51,
    pattern  => '**',
    config   => {
      path   => '/tmp/my-match-1',
      format => 'json',
    },
  }

  fluentd::config::match { 'my-match-2':
    type     => 'file',
    priority => 49,
    pattern  => 'source2.**',
    config   => {
      path   => '/tmp/my-match-2',
      format => 'json',
    },
  }
}
