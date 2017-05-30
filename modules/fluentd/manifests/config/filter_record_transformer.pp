define fluentd::config::filter_record_transformer (
  $pattern,
  $config   = { },
  $record   = { },
  $priority = 50,
) {

  fluentd::config { "filter_record_transformer-${title}":
    content  => template('fluentd/config/filter_record_transformer.conf.erb'),
    priority => $priority,
  }

}
