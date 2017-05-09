define fluentd::config::source (
  $type,
  $config = { },
  $priority = 10,
) {

  fluentd::config { "source-${title}":
    content  => template( 'fluentd/config/source.conf.erb' ),
    priority => $priority,
  }

}
