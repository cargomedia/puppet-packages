define fluentd::config::match_copy (
  $pattern,
  $config   = { },
  $stores   = [ ],
  $priority = 80,
) {
  fluentd::config { "match_copy-${name}":
    content  => template('fluentd/config/match_copy.conf.erb'),
    priority => $priority,
  }
}
