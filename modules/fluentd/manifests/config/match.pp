define fluentd::config::match (
  $pattern,
  $type,
  $config = { },
  $priority = 50,
) {

  fluentd::config { "match-${title}":
    content  => template( 'fluentd/config/match.conf.erb' ),
    priority => $priority,
  }

}
