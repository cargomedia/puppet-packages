define fluentd::config::match_forest (
  $pattern,
  $subtype,
  $config = { },
  $template = { },
  $priority = 80,
) {

  include 'fluentd::plugin::forest'

  $type = 'forest'

  fluentd::config { "match_forest-${title}":
    content  => template( 'fluentd/config/match_forest.conf.erb' ),
    priority => $priority,
    require => Class['fluentd::plugin::forest'],
  }

}
