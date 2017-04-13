define fluentd::config::filter (
  $pattern,
  $type,
  $config = { },
  $priority = 50,
) {

  @fluentd::config { "filter-${title}":
    content  => template( 'fluentd/config/filter.conf.erb' ),
    priority => $priority,
  }

}
