define fluentd::config::match_elasticsearch (
  $pattern,
  $priority        = 80,
  $hosts,
  $index_name,
  $type_name,
  $include_tag_key = true,
  $logstash_format = false,
  $time_precision  = 3,
  $buffer_type     = 'memory',
  $flush_interval  = 1,

) {
  include 'fluentd::plugin::elasticsearch'

  fluentd::config::match { "elasticsearch-${name}":
    pattern  => $pattern,
    type     => 'elasticsearch',
    priority => $priority,
    config   => {
      hosts           => join($hosts, ','),
      index_name      => $index_name,
      type_name       => $type_name,
      include_tag_key => $include_tag_key,
      logstash_format => $logstash_format,
      time_precision  => $time_precision,
      buffer_type     => $buffer_type,
      flush_interval  => $flush_interval,
    }
  }
}

