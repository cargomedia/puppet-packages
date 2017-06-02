class fluentd::default_config {

  class { 'fluentd::config::filter_add_hostname':
    pattern  => '**',
  }

  class {'fluentd::config::filter_streamline_levels':
    pattern => '**',
  }

  fluentd::config::match { 'drop-fluent-log':
    pattern => 'fluent.*',
    type    => 'null',
  }
}
