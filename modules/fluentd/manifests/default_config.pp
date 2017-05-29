class fluentd::default_config {

  class { 'fluentd::config::filter_add_hostname':
    pattern  => '**',
  }

  class { 'fluentd::config::filter_streamline_priorities':
    pattern => '**',
  }

  class {'fluentd::config::filter_streamline_levels':
    pattern => '**',
  }

}
