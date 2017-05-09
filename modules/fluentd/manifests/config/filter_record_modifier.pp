define fluentd::config::filter_record_modifier (
  $pattern,
  $config = { },
  $record = { },
  $priority = 50,
) {

  include 'fluentd::plugin::record_modifier'

  fluentd::config { "filter_record_modifier-${title}":
    content  => template( 'fluentd/config/filter_record_modifier.conf.erb' ),
    priority => $priority,
    require => Class['fluentd::plugin::record_modifier'],
  }

}
