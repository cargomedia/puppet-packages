define fluentd::config::match_retag (
  $pattern,
  $config = { },
  $priority = 80,
) {

  include 'fluentd::plugin::rewrite_tag'

  $type = 'rewrite_tag_filter'
  fluentd::config { "match-retag-${title}":
    content  => template( 'fluentd/config/match.conf.erb' ),
    priority => $priority,
  }

}
